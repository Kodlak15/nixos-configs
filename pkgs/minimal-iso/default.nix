# {self, ...}: self.nixosConfigurations."iso-minimal".config.system.build.isoImage
{pkgs, ...}: let
  cd = import pkgs.nixos.modules.installer.cd-dvd.installation-cd-minimal.nix;
in
  cd.nixosConfigurations."iso-minimal".config.system.build.isoImage
