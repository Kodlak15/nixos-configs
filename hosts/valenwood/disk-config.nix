{lib, ...}: {
  fileSystems."/persist".neededForBoot = true;

  swapDevices = [];

  disko.devices = {
    disk.valenwood = {
      type = "disk";
      # SSH into host system and get target disk before running nixos-anywhere
      device = lib.mkDefault "/dev/vda";
      content = {
        type = "gpt";
        partitions = {
          esp = {
            # label = "valenwood-boot";
            name = "ESP";
            size = "512M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              extraArgs = ["-n" "vwood-boot"];
              mountOptions = [
                "defaults"
              ];
            };
          };
          luks = {
            name = "luks";
            size = "100%";
            content = {
              type = "luks";
              name = "root";
              extraFormatArgs = ["--label vwood-luks"];
              extraOpenArgs = [
                "--allow-discards"
                "--perf-no_read_workqueue"
                "--perf-no_write_workqueue"
              ];
              settings = {
                # https://0pointer.net/blog/unlocking-luks2-volumes-with-tpm2-fido2-pkcs11-security-hardware-on-systemd-248.html
                crypttabExtraOpts = ["fido2-device=auto" "token-timeout=10"];
              };
              content = {
                type = "btrfs";
                extraArgs = ["-L" "valenwood" "-f"];
                subvolumes = {
                  "/root" = {
                    mountpoint = "/";
                    mountOptions = ["subvol=@root" "compress=zstd" "noatime"];
                  };
                  "/home" = {
                    mountpoint = "/home";
                    mountOptions = ["subvol=@home" "compress=zstd" "noatime"];
                  };
                  "/nix" = {
                    mountpoint = "/nix";
                    mountOptions = ["subvol=@nix" "compress=zstd" "noatime"];
                  };
                  "/persist" = {
                    mountpoint = "/persist";
                    mountOptions = ["subvol=@persist" "compress=zstd" "noatime"];
                  };
                  # "/swap" = {
                  #   mountpoint = "/swap";
                  #   swap.swapfile.size = "4G";
                  # };
                };
              };
            };
          };
        };
      };
    };
  };
}
