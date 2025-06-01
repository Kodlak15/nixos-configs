{
  wayland.windowManager.hyprland = {
    extraConfig = ''
      env = HYPRCURSOR_THEME,rose-pine-hyprcursor
      env = HYPRCURSOR_SIZE,16

      # Toolkit-specific scale
      env = GDK_SCALE,2

      env = CLUTTER_BACKEND,wayland
      env = SDL_VIDEODRIVER,wayland
      env = XDG_SESSION_TYPE,wayland
      env = XDG_CURRENT_DESKTOP,Hyprland
      env = XDG_SESSION_DESKTOP,Hyprland
      env = MOZ_ENABLE_WAYLAND,1
      env = MOZ_DBUS_REMOTE,1
      env = GDK_BACKEND,wayland,xll,*
      env = QT_QPA_PLATFORM,wayland

      # Needed to run steam in offload mode
      env = XDG_DATA_HOME,$HOME/.local/share

      env = GBM_BACKEND,nvidia-drm
      env = __GLX_VENDOR_LIBRARY_NAME,nvidia
      env = LIBVA_DRIVER_NAME,nvidia
      env = __GL_GSYNC_ALLOWED,1

      env = NIXOS_OZONE_WL,1
      env = ELECTRON_OZONE_PLATFORM_HINT,auto

      # Nix configuration
      env = NIXCGF,$HOME/nix/flakes/nixos/
    '';
  };
}
