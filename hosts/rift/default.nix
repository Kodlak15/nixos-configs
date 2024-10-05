{
  pkgs,
  lib,
  modulesPath,
  inputs,
  config,
  ...
}: {
  imports = [
    inputs.sops-nix.nixosModules.sops
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./disk-config.nix
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  networking.hostName = "rift";

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  sops = {
    age = {
      sshKeyPaths = ["/persist/etc/ssh/ssh_host_ed25519_key"];
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = true;
    };
    secrets = {
      password = {
        sopsFile = ./secrets.yaml;
        neededForUsers = true;
      };
    };
  };

  users = {
    mutableUsers = false;
    users = {
      cody = {
        isNormalUser = true;
        shell = pkgs.zsh;
        ignoreShellProgramCheck = true;
        hashedPasswordFile = config.sops.secrets.password.path;
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN0jIg6UYuO+MSjBEcaaJXAoY3yLl7q7tqMVB0yFiqGr"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB3fdO9C72OaYhK3W2OhINnlRCcopOblJJI/z9frc1F0"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHwaOrqTJ6Xq8qU3y/Vn02tHMUZJISNRA/fLAVfYCN21"
        ];
        group = "cody";
        extraGroups = [
          "wheel"
          "docker"
          "wireshark"
        ];
      };
      root = {
        initialHashedPassword = "$y$j9T$vVNMHVnnesyBcnbDxNQ7T/$JqywYFyoePyzWLEW822Sv2pWYyQoLJgAo.wCzurMyNC";
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN0jIg6UYuO+MSjBEcaaJXAoY3yLl7q7tqMVB0yFiqGr"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB3fdO9C72OaYhK3W2OhINnlRCcopOblJJI/z9frc1F0"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHwaOrqTJ6Xq8qU3y/Vn02tHMUZJISNRA/fLAVfYCN21"
        ];
      };
    };
    # TODO:
    groups = {
      cody = {};
    };
  };

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
    pcscd.enable = true;
  };

  programs = {
    gnupg = {
      agent = {
        enable = true;
        pinentryPackage = pkgs.pinentry-curses;
        enableSSHSupport = true;
      };
    };
  };

  environment = {
    systemPackages = with pkgs; [
      curl
      wget
      git
      libfido2
      virtiofsd
      gnumake
      ripgrep
      sops
      pass
    ];
    persistence."/persist" = {
      enable = true;
      hideMounts = true;
      directories = [
        "/var/log"
        "/var/lib/bluetooth"
        "/var/lib/nixos"
        "/var/lib/sops-nix"
        "/var/lib/systemd/coredump"
        "/etc/NetworkManager/system-connections"
        "/etc/ssh"
      ];
    };
    shells = with pkgs; [zsh];
    variables = {
      EDITOR = "${pkgs.neovim}";
    };
  };

  system.stateVersion = "24.05";
}
