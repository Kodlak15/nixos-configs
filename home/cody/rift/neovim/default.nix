{
  pkgs,
  inputs,
  ...
}: let
  neovim = inputs.nvim.packages.${pkgs.system}.default;
in {
  home.packages = with pkgs;
    [
      python311Packages.black
      python311Packages.isort
    ]
    ++ [neovim];
}
