{
  pkgs,
  inputs,
  ...
}: let
  cfg = builtins.fetchGit {
    url = "https://github.com/Kodlak15/eww-configs";
    rev = "febb2fdffe9211d6d3127cfa8d0e9d7da6ac2aac";
  };
in {
  programs.eww = {
    enable = true;
    package = inputs.eww.packages.${pkgs.system}.eww;
    configDir = cfg + "/everest";
  };
}
