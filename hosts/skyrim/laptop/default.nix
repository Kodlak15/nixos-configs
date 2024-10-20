{
  config,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./disk-config.nix
  ];

  networking.hostName = "skyrim";

  # sops = {
  #   age = {
  #     sshKeyPaths = ["/persist/etc/ssh/ssh_host_ed25519_key"];
  #     keyFile = "/var/lib/sops-nix/key.txt";
  #     generateKey = true;
  #   };
  #   secrets = {
  #     password = {
  #       sopsFile = ./secrets.yaml;
  #       neededForUsers = true;
  #     };
  #   };
  # };

  boot = {
    loader = {
      grub = {
        enable = true;
        devices = ["nodev"];
        efiSupport = true;
        efiInstallAsRemovable = true;
      };
    };
    initrd = {
      # https://nixos.org/manual/nixos/stable/#sec-luks-file-systems-fido2
      systemd = {
        enable = true;
        services = {
          wipe-root = {
            requires = ["dev-mapper-root.device"];
            after = ["dev-mapper-root.device"];
            wantedBy = ["initrd.target"];
            script = lib.mkAfter ''
              mkdir /btrfs_tmp
              mount /dev/mapper/root /btrfs_tmp
              if [[ -e /btrfs_tmp/root ]]; then
                  mkdir -p /btrfs_tmp/old_roots
                  timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
                  mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
              fi

              delete_subvolume_recursively() {
                  IFS=$'\n'
                  for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
                      delete_subvolume_recursively "/btrfs_tmp/$i"
                  done
                  btrfs subvolume delete "$1"
              }

              for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +30); do
                  delete_subvolume_recursively "$i"
              done

              btrfs subvolume create /btrfs_tmp/root
              umount /btrfs_tmp
            '';
          };
        };
      };
    };
  };

  hardware = {
    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = true;
      nvidiaSettings = true;
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  users = {
    # mutableUsers = false;
    users.cody = {
      # hashedPasswordFile = config.sops.secrets.password.path;
      hashedPassword = "$y$j9T$o3IYxTwHmV1ocaOXDcNhs/$z.746YINjBuHcnEkALGK3jdUzUasNTx4f8WQpSUqyY9";
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "audio"
        "video"
        "input"
        "dialout"
        "docker"
        "libvirtd"
        "wireshark"
        "networkmanager"
      ];
      openssh.authorizedKeys.keys = [];
    };
  };

  environment = {
    persistence."/persist" = {
      enable = true;
      hideMounts = true;
      directories = [
        "/var/log"
        "/var/lib/bluetooth"
        "/var/lib/nixos"
        "/var/lib/sops-nix"
        "/var/lib/systemd/coredump"
        "/var/lib/libvirt"
        "/var/cache/mullvad-vpn"
        "/etc/mullvad-vpn"
        "/etc/NetworkManager/system-connections"
        "/etc/ssh"
      ];
    };
  };

  system.stateVersion = "23.05";
}
