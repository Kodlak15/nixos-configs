{config, ...}: let
  luks = "nixos-crypt";
  luksPart = "/dev/disk/by-label/NIXOS";
  rootPart = "/dev/disk/by-label/ROOT";
  bootPart = "/dev/disk/by-label/EFI-NIXOS";
in {
  imports = [
    ./hardware-configuration.nix
  ];

  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        devices = ["nodev"];
        efiSupport = true;
        useOSProber = true;
      };
    };
    initrd = {
      kernelModules = ["vfat" "nls_cp437" "nls_iso8859-1" "usbhid"];
      luks = {
        yubikeySupport = true;
        devices.${luks} = {
          device = luksPart;
          yubikey = {
            slot = 2;
            twoFactor = true;
            gracePeriod = 30;
            keyLength = 64;
            saltLength = 16;
            storage = {
              device = bootPart;
              fsType = "vfat";
              path = "/crypt-storage/default";
            };
          };
        };
      };
    };
  };

  fileSystems = {
    "/" = {
      device = rootPart;
      fsType = "btrfs";
      options = ["subvol=@"];
    };
    "/home" = {
      device = rootPart;
      fsType = "btrfs";
      options = ["subvol=@home"];
    };
    "/tmp" = {
      device = rootPart;
      fsType = "btrfs";
      options = ["subvol=@tmp"];
    };
    "/var" = {
      device = rootPart;
      fsType = "btrfs";
      options = ["subvol=@var"];
    };
  };

  swapDevices = [];

  networking.hostName = "skyrim";

  # sops = {
  #   age = {
  #     sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
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

  hardware = {
    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = true;
      nvidiaSettings = true;
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
        "docker"
        "libvirtd"
        "wireshark"
        "usb"
        "plugdev"
        "networkmanager"
      ];
      openssh.authorizedKeys.keys = [];
    };
  };

  system.stateVersion = "23.05";
}
