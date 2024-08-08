let
  rootPart = "/dev/disk/by-label/ROOT";
  bootPart = "/dev/disk/by-label/EFI-NIXOS";
in {
  imports = [
    ./hardware-configuration.nix
  ];

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
    "/boot" = {
      device = bootPart;
      fsType = "vfat";
    };
  };

  swapDevices = [];

  boot = {
    # loader.systemd-boot.enable = true;
    loader = {
      grub = {
        enable = true;
        # devices = ["nodev"];
        # device = bootPart;
        device = "/dev/sda";
        efiSupport = true;
        efiInstallAsRemovable = true;
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
  };
}
