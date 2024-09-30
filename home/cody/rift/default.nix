{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./i3
    ./firefox
  ];

  home = {
    username = "cody";
    homeDirectory = lib.mkDefault "/home/cody";

    packages = with pkgs; [
      kitty
      neofetch
    ];

    stateVersion = "24.05";
  };
}
