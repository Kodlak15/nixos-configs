{
  powder = {
    enable = true;
    # TODO this should be a list of attribute sets
    systems = {
      default = true;
      flake = {
        path = "/home/cody/nix/flakes/nixos";
        url = "github:Kodlak15/nixos-flake";
      };
      nixos.name = "personal/everest";
      home.user = "cody";
      disks = {
        encryption = {
          enable = true;
          label = "NIXOS";
          mapping = "nixos-crypt";
          smartcard = {
            enable = true;
            slot = 2;
            saltLength = 16;
            cipher = "aes-xts-plain64";
            hash = "sha512";
          };
        };
        root = {
          label = "NIXOS";
          size = null; # use rest of disk
          filesystem = "btrfs";
        };
        boot = {
          label = "EFI-NIXOS";
          size = 512;
        };
      };
      jobs = 8;
    };
  };
}
