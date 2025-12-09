{
  wayland.windowManager.hyprland = {
    settings.windowrule = [
      # ISSUE: https://github.com/hyprwm/Hyprland/discussions/8078
      # "match:class (brave)(.*), match:title (Bitwarden), float 1"
      "match:title (Reflex), float 1"
      "match:title (LearnOpenGL), float 1"
    ];
  };
}
