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
      # https://nixos.org/manual/nixos/stable/#sec-luks-file-systems-fido2
      systemd.enable = true;
      # NOTE: alternative to systemd init, but can't seem to get to work
      # luks = {
      #   fido2Support = true;
      #   devices = {
      #     root = {
      #       # device = "/dev/disk/by-partlabel/rift-luks";
      #       fido2 = {
      #         # credential = "3d0007a9276300ba9c7eae1318465567da8c67706c43043809ff0c4f2d3bb6507eab72473c4432b640d594938e2c98a8";
      #         # credential = "2a0dcdae3cd8b487047654e67d3db7eca5ae2149f19cb466fd355157a520e47c365af39171ec7b8ffeacd9dcf0fa0a47";
      #         credential = "7cfb3fd5553be7bc3849f3798ebf7f0ba680ad8a6bc69f09b3ac997d4e2a1c29978be78a4636b285f6cb32c25869725a";
      #         passwordLess = true;
      #       };
      #     };
      #   };
      # };
      # NOTE: cannot be used alongside systemd during initrd
      # will need to find another way to handle impermanence
      # postDeviceCommands = lib.mkAfter ''
      #   mkdir /btrfs_tmp
      #   mount /dev/mapper/root /btrfs_tmp
      #   if [[ -e /btrfs_tmp/root ]]; then
      #       mkdir -p /btrfs_tmp/old_roots
      #       timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
      #       mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
      #   fi
      #
      #   delete_subvolume_recursively() {
      #       IFS=$'\n'
      #       for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
      #           delete_subvolume_recursively "/btrfs_tmp/$i"
      #       done
      #       btrfs subvolume delete "$1"
      #   }
      #
      #   for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +30); do
      #       delete_subvolume_recursively "$i"
      #   done
      #
      #   btrfs subvolume create /btrfs_tmp/root
      #   umount /btrfs_tmp
      # '';
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
      libfido2
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
    shells = with pkgs; [zsh];
    variables = {
      EDITOR = "${pkgs.neovim}";
    };
  };

  users = {
    users = {
      cody = {
        shell = pkgs.zsh;
        ignoreShellProgramCheck = true;
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
