{
  wayland.windowManager.hyprland = {
    extraConfig = ''
      # windowrule = opacity 1.0 override 1.0 override, ^(firefox)$
      windowrule = opacity 1.0 override 1.0 override, ^(librewolf)$
      windowrule = opacity 1.0 override 1.0 override, ^(brave-browser)$
      windowrule = opacity 1.0 override 1.0 override, ^(virt-manager)$
      windowrule = opacity 1.0 override 1.0 override, ^(thunar)$
      windowrulev2 = opacity 1.0 override 1.0 override, initialTitle:(Mozilla Firefox)
      windowrulev2 = opacity 1.0 override 1.0 override, initialTitle:(Firefox Developer Edition)
      windowrulev2 = opacity 1.0 override 1.0 override, initialTitle:(Spotify Premium)
      windowrulev2 = opacity 1.0 override 1.0 override, initialTitle:(Smithay)
      windowrulev2 = opacity 1.0 override 1.0 override, initialTitle:(Cursor)
      windowrule = opacity 0.95 0.95, class:^(nvim)$
    '';
  };
}
