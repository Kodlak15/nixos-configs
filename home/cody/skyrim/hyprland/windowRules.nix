{
  wayland.windowManager.hyprland = {
    extraConfig = ''
      # Unable to get browser windows to open based on title for the time being
      # This discussion seems to pertain to this issue: https://github.com/hyprwm/Hyprland/discussions/8078
      windowrulev2 = float, class:(firefox), title:^(.*)(Bitwarden)(.*)$
      windowrulev2 = float, class:(brave)(.*), title:^(.*)(Bitwarden)(.*)$
      # windowrulev2 = opacity 0.80, initialClass:(com.mitchellh.ghostty)
    '';
  };
}
