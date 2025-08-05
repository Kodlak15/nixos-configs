{inputs, ...}: {
  imports = [
    inputs.hyprland.homeManagerModules.default
    ../common/brave
    ../common/ghostty
    ../common/gtk
    ../common/neovim
    ../common/webull
    ../common/zellij
    ../common/zsh
  ];

  home = {
    username = "cody";
    homeDirectory = "/home/cody";

    stateVersion = "23.05";
  };

  # Let home-manager install and manager itself
  programs.home-manager.enable = true;
}
