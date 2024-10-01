{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./firefox
    ./git
    ./i3
    ./kitty
    ./neovim
    ./zellij
    ./zsh
  ];

  home = {
    username = "cody";
    homeDirectory = lib.mkDefault "/home/cody";

    packages = with pkgs; [
      neofetch
      p7zip
      fzf
      bat
      eza
      jq
    ];

    stateVersion = "24.05";
  };
}
