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
      };
    };
    extraConfig = ''

      # Get rid of default wallpaper
      misc {
        disable_hyprland_logo=1
        disable_splash_rendering=1
      }

      # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
      input {
          kb_layout = us
          kb_variant =
          kb_model =
          kb_options =
          kb_rules =
          follow_mouse = 1
          touchpad {
              natural_scroll = false
          }
      }

      cursor {
        no_hardware_cursors = true
      }
    '';
  };
}
