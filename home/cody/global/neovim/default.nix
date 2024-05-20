{
  pkgs,
  inputs,
  ...
}: let
  neovim = inputs.nvim.packages.${pkgs.system}.default;
in {
  home.packages = [neovim];
}
