let
  luks = "nixos-crypt";
  luksPart = "/dev/disk/by-label/NIXOS";
  rootPart = "/dev/disk/by-label/ROOT";
in {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.initrd.luks.devices.${luks}.device = luksPart;

  fileSystems = {
    "/" = {
      device = "${rootPart}";
      fsType = "btrfs";
      options = ["subvol=@"];
    };
    "/home" = {
      device = "${rootPart}";
      fsType = "btrfs";
      options = ["subvol=@home"];
    };
    "/tmp" = {
      device = "${rootPart}";
      fsType = "btrfs";
      options = ["subvol=@tmp"];
    };
    "/var" = {
      device = "${rootPart}";
      fsType = "btrfs";
      options = ["subvol=@var"];
    };
  };

  swapDevices = [];
}
