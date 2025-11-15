{
  wayland.windowManager.hyprland = {
    settings.animations = {
      enabled = true;
      bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
      animation = [
        "windows, 1, 8, myBezier, slide"
        "windowsOut, 1, 8, myBezier, slide"
        "border, 1, 10, default"
        "borderangle, 1, 8, default"
        "fade, 1, 7, default"
        "workspaces, 1, 6, default"
      ];
    };
    # extraConfig = ''
    #   animations {
    #       enabled = true
    #       bezier = myBezier, 0.05, 0.9, 0.1, 1.05
    #       animation = windows, 1, 8, myBezier, slide
    #       animation = windowsOut, 1, 8, myBezier, slide
    #       animation = border, 1, 10, default
    #       animation = borderangle, 1, 8, default
    #       animation = fade, 1, 7, default
    #       animation = workspaces, 1, 6, default
    #   }
    # '';
  };
}
