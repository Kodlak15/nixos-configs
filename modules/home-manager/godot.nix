{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.programs.godot;
in {
  options.programs.godot = {
    enable = lib.mkEnableOption "godot";
    package = lib.mkOption {
      default = pkgs.godot;
      description = "The godot package to use.";
    };
    settings = {
      interface.theme = {
        preset = lib.mkOption {
          type = lib.types.str;
          default = "Default";
        };
        base_color = {
          red = lib.mkOption {
            type = lib.types.float;
            default = 10.20;
            description = "Sets the red value of the base color (0.0-255.0)";
          };
          green = lib.mkOption {
            type = lib.types.float;
            default = 58.65;
            description = "Sets the green value of the base color (0.0-255.0)";
          };
          blue = lib.mkOption {
            type = lib.types.float;
            default = 68.85;
            description = "Sets the blue value of the base color (0.0-255.0)";
          };
          alpha = lib.mkOption {
            type = lib.types.float;
            default = 1.0;
            description = "Sets the alpha value of the base color (0.0-1.0)";
          };
        };
        accent_color = {
          red = lib.mkOption {
            type = lib.types.float;
            default = 38.25;
            description = "Sets the red value of the accent color (0.0-255.0)";
          };
          green = lib.mkOption {
            type = lib.types.float;
            default = 140.25;
            description = "Sets the green value of the accent color (0.0-255.0)";
          };
          blue = lib.mkOption {
            type = lib.types.float;
            default = 68.85;
            description = "Sets the blue value of the accent color (0.0-255.0)";
          };
          alpha = lib.mkOption {
            type = lib.types.float;
            default = 1.0;
            description = "Sets the alpha value of the accent color (0.0-1.0)";
          };
        };
      };
      run.platforms.linuxbsd.preferWayland = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
    };
  };

  config = let
    shortVersion = with lib;
      strings.concatStringsSep "." (lists.sublist 0 2 (strings.splitString "." cfg.package.version));
    baseColor = cfg.settings.interface.theme.base_color;
    accentColor = cfg.settings.interface.theme.accent_color;
    preferWayland = lib.boolToString cfg.settings.run.platforms.linuxbsd.preferWayland;
    toGodotColor = color: "Color(${toString (color.red / 255.0)}, ${toString (color.green / 255.0)}, ${toString (color.blue / 255)}, ${toString color.alpha})";
  in {
    home.packages = lib.mkIf cfg.enable [cfg.package];
    xdg.configFile."godot/${"editor_settings-" + shortVersion + ".tres"}".text = ''
      [gd_resource type="EditorSettings" load_steps=2 format=3]

      [sub_resource type="InputEventKey" id="InputEventKey_2oq22"]
      keycode = 4194326

      [resource]
      interface/theme/preset = "${cfg.settings.interface.theme.preset}"
      interface/theme/base_color = ${toGodotColor baseColor}
      interface/theme/accent_color = ${toGodotColor accentColor}
      interface/theme/contrast = 0.3
      editors/3d_gizmos/gizmo_settings/bone_axis_length = 0.1
      run/platforms/linuxbsd/prefer_wayland = ${preferWayland}
      export/android/java_sdk_path = ""
      export/android/android_sdk_path = ""
      export/android/debug_keystore = "/home/cody/.local/share/godot/keystores/debug.keystore"
      export/android/debug_keystore_pass = "android"
      export/macos/rcodesign = ""
      export/web/http_port = 8060
      export/web/tls_key = ""
      export/web/tls_certificate = ""
      export/windows/rcedit = ""
      export/windows/osslsigncode = ""
      export/windows/wine = ""
      _default_feature_profile = ""
      _use_favorites_root_selection = false
      network/debug_adapter/request_timeout = 1000
      editors/grid_map/editor_side = 1
      _editor_settings_advanced_mode = false
      _project_settings_advanced_mode = false
      _export_template_download_directory = ""
      _script_setup_templates_dictionary = {
      "Area2D": "0NodeDefault",
      "CharacterBody2D": "0CharacterBody2DBasic Movement",
      "Node2D": "0NodeDefault"
      }
      _script_setup_use_script_templates = false
      shortcuts = [{
      "name": "spatial_editor/viewport_zoom_modifier_1",
      "shortcuts": [SubResource("InputEventKey_2oq22")]
      }, {
      "name": "spatial_editor/viewport_zoom_modifier_2",
      "shortcuts": []
      }]
      metadata/script_setup_templates_dictionary = {
      "CharacterBody3D": "0ObjectEmpty",
      "Label": "0NodeDefault",
      "Node3D": "0NodeDefault"
      }
    '';
  };
}
