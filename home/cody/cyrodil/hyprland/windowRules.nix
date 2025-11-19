{
  wayland.windowManager.hyprland = {
    settings.windowrule = [
      # ISSUE: https://github.com/hyprwm/Hyprland/discussions/8078
      "float, class:(brave)(.*), title:(Bitwarden)"
    ];
  };
}
