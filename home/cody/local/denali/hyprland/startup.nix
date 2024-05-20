{
  wayland.windowManager.hyprland = {
    extraConfig = ''
      # Set XWayland scale
      exec-once=xprop -root -f _XWAYLAND_GLOBAL_OUTPUT_SCALE 32c -set _XWAYLAND_GLOBAL_OUTPUT_SCALE 2

      # Startup scripts
      exec-once = swww init
      exec-once = $HOME/.nix-profile/bin/eww open bar 2> /home/cody/tmp/ewwinit.log
    '';
  };
}
