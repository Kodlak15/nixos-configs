{
  pkgs,
  inputs,
  ...
}: let
  system = pkgs.stdenv.hostPlatform.system;
in {
  home.packages = [inputs.nvim.packages.${system}.default];
}
