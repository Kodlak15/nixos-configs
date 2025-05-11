{
  wayland.windowManager.hyprland = {
    settings = {
      general = {
        gaps_in = 2;
        gaps_out = 4;
        border_size = 2;
        "col.active_border" = "rgba(ffffffff)";
        "col.inactive_border" = "rgba(ffcc66ff) rgba(00000000) 90deg";
        layout = "dwindle";
      };
      decoration = {
        rounding = 8;
        blur = {
          enabled = true;
          size = 8;
          ignore_opacity = true;
          passes = 3;
          noise = 0.01;
          vibrancy = 0.2;
          vibrancy_darkness = 0.5;
        };
        fullscreen_opacity = 1.0;
        active_opacity = 1.0;
        inactive_opacity = 1.0;
      };
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };
    };
  };
}
