{
  wayland.windowManager.hyprland = {
    extraConfig = ''
      general {
          gaps_in = 2
          gaps_out = 4
          border_size = 2
          col.active_border = rgba(ffffffff)
          col.inactive_border = $color11 rgba(00000000) 90deg
          layout = dwindle
      }

      decoration {
          # rounding = 10
          rounding = 2
          blur {
            enabled = false
          }
          drop_shadow = false
          shadow_range = 4
          shadow_render_power = 3
          col.shadow = rgba(1a1a1aee)
          fullscreen_opacity = 1.0
          active_opacity = 0.95
          inactive_opacity = 0.95
          # active_opacity = 0.90
          # inactive_opacity = 0.90
      }

      dwindle {
          pseudotile = true # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
          preserve_split = true # you probably want this
      }

      # master {
      #     new_is_master = true
      # }
    '';
  };
}
