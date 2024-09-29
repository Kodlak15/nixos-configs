{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # ./keybinds.nix
    # ./environment.nix
    # ./windowRules.nix
    # ./windowSettings.nix
    # ./startup.nix
    # ./monitors.nix
    # ./startup.nix
    # ./animations.nix
    # ./colors.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
    plugins = [];
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
          sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
      }

      bind = ALT_L, Return, exec, kitty

      gestures {
          workspace_swipe = false
      }

      debug {
        disable_logs = false
      }

      cursor {
        no_hardware_cursors = true
      }
    '';
  };
}
