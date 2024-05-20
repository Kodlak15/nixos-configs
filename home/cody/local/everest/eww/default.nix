{
  pkgs,
  inputs,
  ...
}: let
  cfg = builtins.fetchGit {
    url = "https://github.com/Kodlak15/eww-configs";
    rev = "e48b34c23c85ef052e3bc69b6fb817a8e79c6680";
  };
in {
  programs.eww = {
    enable = true;
    package = inputs.eww.packages.${pkgs.system}.eww;
    configDir = cfg + "/everest";
  };
}
