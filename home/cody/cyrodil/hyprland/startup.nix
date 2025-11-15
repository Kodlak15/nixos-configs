{
  wayland.windowManager.hyprland = {
    settings.exec-once = [
      # Set XWayland scale
      "xprop -root -f _XWAYLAND_GLOBAL_OUTPUT_SCALE 32c -set _XWAYLAND_GLOBAL_OUTPUT_SCALE 1"
      # Startup scripts
      "mullvad connect"
      "eww open status-bar"
    ];
    # extraConfig = ''
    #   # Set XWayland scale
    #   exec-once=xprop -root -f _XWAYLAND_GLOBAL_OUTPUT_SCALE 32c -set _XWAYLAND_GLOBAL_OUTPUT_SCALE 1
    #
    #   # Startup scripts
    #   exec-once = mullvad connect
    #   exec-once = eww open-many status-bar workspaces-toolbar
    # '';
  };
}
