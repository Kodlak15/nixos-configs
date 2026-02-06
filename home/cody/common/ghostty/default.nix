{configType, ...}: {
  imports = [./ghostty-colors.nix];

  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      theme = "ayu_dark";
      font-family = "FiraCode Nerd Font Mono";
      font-size =
        if configType == "skyrim"
        then 14
        else 12;
      gtk-titlebar = false;
      window-padding-x = 6;
      window-padding-y = 6;
      window-inherit-working-directory = false;
      working-directory = "home";
      background-opacity = 1.0;
    };
  };
}
