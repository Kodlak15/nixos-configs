{
  pkgs,
  inputs,
  ...
}: let
  cfg = builtins.fetchGit {
    url = "https://github.com/Kodlak15/eww-configs";
    rev = "be7ec7770107164dc7da3325fba6a1a7236a1a9d";
  };
in {
  programs.eww = {
    enable = true;
    package = inputs.eww.packages.${pkgs.system}.eww;
    configDir = cfg + "/denali";
  };
}
