{
  pkgs,
  inputs,
  ...
}: let
  cfg = builtins.fetchGit {
    url = "https://github.com/Kodlak15/eww-configs";
    rev = "3be912a5d1d146d41b742dbfb1be6049ae231548";
  };
in {
  programs.eww = {
    enable = true;
    package = inputs.eww.packages.${pkgs.system}.eww;
    configDir = cfg;
  };
}
