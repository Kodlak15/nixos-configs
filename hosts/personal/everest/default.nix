{pkgs, ...}: let
  uuidFile = import ./get-uuid.nix {inherit pkgs;};
  uuid = builtins.readFile uuidFile;
  hwconfig = ./${uuid}/hardware-configuration.nix;
in {
  imports = [
    # hwconfig
    ./hardware-configuration.nix
  ];
}
