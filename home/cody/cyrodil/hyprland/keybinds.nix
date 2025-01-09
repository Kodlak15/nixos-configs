let
  setWallpaperDir = imgDir: "swwwmgr -d $HOME/.config/wallpaper/${imgDir} && eww reload";
  nextWallpaper = "swwwmgr -n && eww reload";
  prevWallpaper = "swwwmgr -p && eww reload";
  randomWallpaper = "swwwmgr -r && eww reload";
in {
  wayland.windowManager.hyprland = {
    extraConfig = ''
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
          "$mod, RETURN, exec, ghostty"
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
          ", F1, exec, wpctl set-mute @DEFAULT_SINK@ toggle"
          ", F2, exec, wpctl set-volume @DEFAULT_SINK@ 0.05-"
          ", F3, exec, wpctl set-volume @DEFAULT_SINK@ 0.05+"
          # Adjust brightness
          ", F6, exec, brightnessctl set 5%-"
          ", F7, exec, brightnessctl set 5%+"
          # Eww
          "$mod, x, exec, $HOME/.config/eww/scripts/window.sh --toggle status-bar"
          "$mod, c, exec, $HOME/.config/eww/scripts/window.sh --toggle control"
          "$mod, l, exec, $HOME/.config/eww/scripts/window.sh --toggle launcher"
          # Change wallpaper
          "$mod ALT_L, s, exec, ${setWallpaperDir "space"}"
          "$mod ALT_L, f, exec, ${setWallpaperDir "forest"}"
          "$mod ALT_L, o, exec, ${setWallpaperDir "ocean"}"
          "$mod ALT_L, m, exec, ${setWallpaperDir "mountains"}"
          "$mod ALT_L, g, exec, ${setWallpaperDir "gaming"}"
          "$mod ALT_L, d, exec, ${setWallpaperDir "digital"}"
          "$mod ALT_L, n, exec, ${nextWallpaper}"
          "$mod ALT_L, p, exec, ${prevWallpaper}"
          "$mod ALT_L, r, exec, ${randomWallpaper}"
        ]
        ++ (builtins.concatLists (builtins.genList (
            i: let
              ws = i + 1;
            in [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod, code:1${toString i}, exec, eww close control"
              "$mod, code:1${toString i}, exec, eww close launcher"
              "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, exec, eww close control"
              "$mod SHIFT, code:1${toString i}, exec, eww close launcher"
            ]
          )
          9));
    };
  };
}
