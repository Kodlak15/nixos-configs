{
  wayland.windowManager.hyprland = {
    settings.exec-once = [
      # Set XWayland scale
      "xprop -root -f _XWAYLAND_GLOBAL_OUTPUT_SCALE 32c -set _XWAYLAND_GLOBAL_OUTPUT_SCALE 1"
      # Connect to vpn
      "mullvad connect"
      # Open status bar
      "eww open status-bar"
      # Start blue light filter
      "wlsunset"
    ];
  };
}
