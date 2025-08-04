{pkgs, ...}: {
  imports = [
    ../common/alacritty
    ../common/brave
    ../common/cursor
    ../common/kitty
    ../common/neovim
    ../common/firefox
    ../common/pywal
    ../common/zellij
    ../common/yubikey
    ../common/git
    ../common/gtk
    ../common/virtualization
    ../common/wallpaper
    ../common/weather
    ../common/webull
  ];

  home = {
    username = "cody";
    homeDirectory = "/home/cody";
    packages = with pkgs; [
      neofetch
      kitty
      fzf
      eza
      bat
      ripgrep
      htop
      tmux
    ];
    stateVersion = "23.05";
  };
}
