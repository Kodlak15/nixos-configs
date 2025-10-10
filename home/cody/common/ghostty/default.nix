{
  imports = [./ghostty-colors.nix];

  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      theme = "ayu_dark";
      font-family = "FiraCode Nerd Font";
      font-size = 12;
      gtk-titlebar = false;
      window-padding-x = 6;
      window-padding-y = 6;
      window-padding-color = "background";
      window-inherit-working-directory = false;
      working-directory = "home";
      background-opacity = 0.80;
    };
  };
}
