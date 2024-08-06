{
  pkgs,
  inputs,
  ...
}: {
  wayland.windowManager.hyprland = {
    extraConfig = ''
      # Toolkit-specific scale
      env = GDK_SCALE,2
      # env = XCURSOR_SIZE,32
      # TODO
      env = HYPRCURSOR_THEME,rose-pine-hyprcursor
      env = HYPRCURSOR_SIZE,16

      # Environment variables
      env = CLUTTER_BACKEND,wayland
      env = SDL_VIDEODRIVER,wayland
      env = XDG_SESSION_TYPE,wayland
      env = XDG_CURRENT_DESKTOP,Hyprland
      env = XDG_SESSION_DESKTOP,Hyprland
      env = MOZ_ENABLE_WAYLAND,1
      env = MOZ_DBUS_REMOTE,1
      env = NIXOS_OZONE_WL,1

      # Needed to run steam in offload mode
      env = XDG_DATA_HOME,$HOME/.local/share
    '';
  };
}
