{
  pkgs,
  inputs,
  ...
}: {
  home.packages = [inputs.nvim.packages.${pkgs.system}.default];
}
