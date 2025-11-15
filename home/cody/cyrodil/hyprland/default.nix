{
  imports = [
    ./animations.nix
    ./devices.nix
    ./environment.nix
    ./input.nix
    ./keybinds.nix
    ./monitors.nix
    ./startup.nix
    ./windowRules.nix
    ./windowSettings.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
    settings = {
      misc = {
        enable_anr_dialog = false;
        disable_hyprland_logo = 1;
        disable_splash_rendering = 1;
      };
      cursor.no_hardware_cursors = true;
    };
  };
}
