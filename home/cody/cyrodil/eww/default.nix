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
    configDir = inputs.eww-configs.packages.${pkgs.system}.default;
    enableZshIntegration = true;
  };
}
