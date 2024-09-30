{lib, ...}: {
  disko.devices = {
    disk.disk1 = {
      device = lib.mkDefault "/dev/vda";
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          esp = {
            name = "ESP";
            size = "512M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
            };
          };
          luks = {
            label = "rift-luks";
            size = "100%";
            content = {
              type = "luks";
              name = "root";
              extraOpenArgs = [
                "--allow-discards"
                "--perf-no_read_workqueue"
                "--perf-no_write_workqueue"
              ];
              # NOTE: https://0pointer.net/blog/unlocking-luks2-volumes-with-tpm2-fido2-pkcs11-security-hardware-on-systemd-248.html
              settings = {crypttabExtraOpts = ["fido2-device=auto" "token-timeout=10"];};
              content = {
                type = "btrfs";
                extraArgs = ["-L" "rift" "-f"];
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
                  "/swap" = {
                    mountpoint = "/swap";
                    swap.swapfile.size = "4G";
                  };
                };
              };
            };
          };
        };
      };
    };
  };

  fileSystems."/persist".neededForBoot = true;
}
