{pkgs ? import <nixpkgs> {}}: let
  config = {
    imports = [
      pkgs.nixos.modules.virtualization.digital-ocean-image.nix
    ];
  };
in
  (pkgs.nixos config).digitalOceanImage
