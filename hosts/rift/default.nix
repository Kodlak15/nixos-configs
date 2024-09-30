{
  pkgs,
  lib,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./disk-config.nix
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  networking.hostName = "rift";

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

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
      postDeviceCommands = lib.mkAfter ''
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

  services = {
    openssh = {
      enable = true;
      ports = [22];
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
      };
    };
    xserver = {
      enable = true;
      windowManager.i3.enable = true;
    };
    displayManager = {
      defaultSession = "none+i3";
    };
  };

  environment = {
    systemPackages = with pkgs; [
      curl
      wget
      git
    ];
    persistence."/persist" = {
      enable = true;
      hideMounts = true;
      directories = [
        "/var/log"
        "/var/lib/bluetooth"
        "/var/lib/nixos"
        "/var/lib/systemd/coredump"
        "/etc/NetworkManager/system-connections"
      ];
    };
  };

  users = {
    users = {
      cody = {
        hashedPassword = "$y$j9T$lIQkLrh/jE5pTGqAVcGCB/$YF1Uk6rTBsRednb2cr.ed8NP7.wKSWcYObe9Gl8RxN0";
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN0jIg6UYuO+MSjBEcaaJXAoY3yLl7q7tqMVB0yFiqGr"
        ];
        group = "cody";
        extraGroups = [
          "wheel"
          "docker"
          "wireshark"
        ];
        isNormalUser = true;
      };
      root = {
        initialHashedPassword = "$y$j9T$vVNMHVnnesyBcnbDxNQ7T/$JqywYFyoePyzWLEW822Sv2pWYyQoLJgAo.wCzurMyNC";
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN0jIg6UYuO+MSjBEcaaJXAoY3yLl7q7tqMVB0yFiqGr"
        ];
      };
    };
    # TODO:
    groups = {
      cody = {};
    };
  };

  system.stateVersion = "24.05";
}
