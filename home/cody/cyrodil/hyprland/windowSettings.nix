{
  wayland.windowManager.hyprland = {
    extraConfig = ''
      general {
          gaps_in = 2
          gaps_out = 4
          border_size = 2
          col.active_border = rgba(ffffffff)
          col.inactive_border = rgba(ffcc66ff) rgba(00000000) 90deg
          layout = dwindle
      }

      decoration {
          # rounding = 2
          rounding = 8
          blur {
            enabled = false
          }
          fullscreen_opacity = 1.0
          active_opacity = 1.0
          inactive_opacity = 1.0
      }

      dwindle {
          pseudotile = true # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
          preserve_split = true # you probably want this
      }
    '';
  };
}
