{
  pkgs,
  inputs,
  ...
}: let
  cfg = builtins.fetchGit {
    url = "https://github.com/Kodlak15/eww-configs";
    rev = "67eb6f5b7deb68c0fc7f1b4371a2e1d2465aabb5";
  };
in {
  programs.eww = {
    enable = true;
    package = inputs.eww.packages.${pkgs.system}.eww;
    configDir = cfg + "/everest";
  };
}
