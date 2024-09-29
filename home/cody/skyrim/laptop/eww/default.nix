{
  pkgs,
  inputs,
  ...
}: {
  programs.eww = {
    enable = true;
    package = inputs.eww.packages.${pkgs.system}.eww;
    # configDir = inputs.eww-configs.packages.${pkgs.system}.denali;
    configDir = inputs.eww-configs.packages.${pkgs.system}.skyrim;
  };
}
