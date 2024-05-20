{...}: {
  imports = [
    ./keybinds.nix
  ];

  wayland.windowManager.hyprland.settings = {
    misc = {
      # disable_hyperland_logo = true;
      disable_splash_rendering = true;
    };
    input = {
      kb_layout = "us";
      follow_mouse = true;
      touchpad.natural_scroll = false;
      sensitivity = 0;
    };
    gestures.workspace_swipe = false;
  };
}
