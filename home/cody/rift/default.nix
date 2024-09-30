{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./firefox
    ./i3
    ./neovim
    ./zellij
  ];

  home = {
    username = "cody";
    homeDirectory = lib.mkDefault "/home/cody";

    packages = with pkgs; [
      neofetch
      p7zip
    ];

    stateVersion = "24.05";
  };
}
