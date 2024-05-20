{
  pkgs,
  inputs,
  ...
}: {
  programs.eww = {
    enable = true;
    # package = inputs.eww.packages.${pkgs.system}.eww-wayland;
    package = inputs.eww.packages.${pkgs.system}.eww;
    configDir = ./config;
  };
}
