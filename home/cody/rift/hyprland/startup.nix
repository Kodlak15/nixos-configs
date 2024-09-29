{
  wayland.windowManager.hyprland = {
    extraConfig = ''
      # Set XWayland scale
      exec-once=xprop -root -f _XWAYLAND_GLOBAL_OUTPUT_SCALE 32c -set _XWAYLAND_GLOBAL_OUTPUT_SCALE 2

      # Startup scripts
      exec-once = eww open-many status-bar workspaces-toolbar
      exec-once = swww init
    '';
  };
}
