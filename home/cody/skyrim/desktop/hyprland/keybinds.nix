{
  wayland.windowManager.hyprland = {
    extraConfig = ''
      # For some reason could not get these working correctly inside settings.bind = [...]
      bindm = ALT_L, mouse:272, movewindow
      bindm = ALT_L, mouse:273, resizewindow
    '';
    settings = {
      "$mod" = "SUPER";
      bind =
        [
          "$mod, q, killactive"
          "$mod, m, exit"
          "$mod, v, toggleFloating"
          "$mod, p, pseudo"
          "$mod, j, togglesplit"
          "$mod, f, fullscreen"
          # "$mod, RETURN, exec, alacritty"
          "$mod, RETURN, exec, kitty"
          "$mod, b, exec, firefox"
          "$mod ALT_L, b, exec, brave"
          "$mod, t, exec, thunar"
          "$mod ALT_L, v, exec, virt-manager"
          "$mod, left, movefocus, l"
          "$mod, right, movefocus, r"
          "$mod, up, movefocus, u"
          "$mod, down, movefocus, d"
          # Scroll through existing workspaces with mainMod + scroll
          "$mod, mouse_down, workspace, e+1"
          "$mod, mouse_up, workspace, e-1"
          # Adjust volume
          ", F1, exec, amixer -D default set Master 1+ toggle"
          ", F2, exec, wpctl set-volume 56 0.05-"
          ", F3, exec, wpctl set-volume 56 0.05+"
          # Adjust brightness
          ", F6, exec, brightnessctl set 5%-"
          ", F7, exec, brightnessctl set 5%+"
          # Eww
          "$mod, x, exec, $HOME/.config/eww/scripts/window.sh --toggle status-bar && $HOME/.config/eww/scripts/window.sh --toggle workspaces-toolbar"
          # Change wallpaper
          "$mod ALT_L, s, exec, swwwmgr -d $HOME/.config/wallpaper/space/ && eww reload"
          "$mod ALT_L, f, exec, swwwmgr -d $HOME/.config/wallpaper/forest/ && eww reload"
          "$mod ALT_L, o, exec, swwwmgr -d $HOME/.config/wallpaper/ocean/ && eww reload"
          "$mod ALT_L, m, exec, swwwmgr -d $HOME/.config/wallpaper/mountains/ && eww reload"
          "$mod ALT_L, g, exec, swwwmgr -d $HOME/.config/wallpaper/gaming/ && eww reload"
          "$mod ALT_L, d, exec, swwwmgr -d $HOME/.config/wallpaper/digital/ && eww reload"
          "$mod ALT_L, n, exec, swwwmgr -n && eww reload"
          "$mod ALT_L, p, exec, swwwmgr -p && eww reload"
          "$mod ALT_L, r, exec, swwwmgr -r && eww reload"
        ]
        ++ (builtins.concatLists (builtins.genList (
            i: let
              ws = i + 1;
            in [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          )
          9));
    };
  };
}
