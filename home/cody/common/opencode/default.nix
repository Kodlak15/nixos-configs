{pkgs, ...}: let
  opencode = pkgs.callPackage ./package.nix {};
in {
  home.packages = [opencode];
}
