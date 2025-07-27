{inputs, ...}: {
  imports = [./ghostty-colors.nix];

  programs.ghostty = {
    enable = true;
    package = inputs.ghostty.packages.x86_64-linux.default;
    enableZshIntegration = true;
    settings = {
      # theme = "ayu";
      theme = "ayu_dark";
      font-family = "Fira Code Nerd Font";
      font-size = 12;
      gtk-titlebar = false;
      window-padding-x = 6;
      window-padding-y = 6;
      window-padding-color = "background";
      background-opacity = 0.80;
      # background-opacity = 1.00;
    };
  };
}
