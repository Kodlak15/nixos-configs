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
    ./common.nix
    ./git.nix
    ./alacritty.nix
    ./zsh.nix
    ./virtualization.nix
    ./gtk.nix
    ./nixpkgs.nix
  ];

  home.pointerCursor = {
    gtk.enable = true;
    # name = "Catppuccin-Mocha-Dark-Cursors";
    # package = pkgs.catppuccin-cursors.mochaDark;
    # package = pkgs.vanilla-dmz;
    # name = "Vanilla-DMZ";
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 16;
  };
}
