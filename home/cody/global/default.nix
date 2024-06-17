{pkgs, ...}: {
  imports = [
    ./neovim
    ./tmux
    ./sops
    ./swwwmgr
    ./weather
    ./firefox
    ./gaming
    ./pywal
    ./zellij
    ./yubikey
    ./common
    ./git
    ./alacritty
    ./zsh
    ./virtualization
    ./gtk
    ./nixpkgs
  ];
}
