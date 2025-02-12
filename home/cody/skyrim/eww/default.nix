{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ../../../../modules/home-manager/eww-fixed.nix
  ];

  disabledModules = [
    "programs/eww.nix"
  ];

  programs.eww = {
    enable = true;
    package = inputs.eww.packages.${pkgs.system}.eww;
    configDir = inputs.eww-configs.packages.${pkgs.system}.default;
  };
}
