{
  pkgs,
  inputs,
  ...
}: {
  programs.eww = {
    enable = true;
    configDir = inputs.eww-configs.packages.${pkgs.system}.default;
    enableZshIntegration = true;
  };
}
