{
  powder = {
    enable = true;
    systems = {
      default = true;
      flake = /home/cody/nix/flakes/nixos;
      nixos.name = "personal/everest";
      hm.user = "testtesttest";
      install = {
        disks = {
          encryption = {
            enable = true;
            label = "NIXOS-CRYPT";
            smartcard = {
              enable = true;
              slot = 2;
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
      };
      jobs = 8;
    };
    # config = ./config.yaml;
  };
}
