{
  wayland.windowManager.hyprland = {
    extraConfig = ''
      windowrule = opacity 1.0 override 1.0 override, ^(firefox)$         # Remove opacity for firefox
      windowrule = opacity 1.0 override 1.0 override, ^(librewolf)$       # Remove opacity for librewolf
      windowrule = opacity 1.0 override 1.0 override, ^(brave-browser)$   # Remove opacity for brave
      windowrule = opacity 1.0 override 1.0 override, ^(virt-manager)$    # Remove opacity for vms
      windowrule = opacity 1.0 override 1.0 override, ^(thunar)$          # Remove opacity for thunar
      windowrule = opacity 1.0 override 1.0 override, ^(spotify)$         # Remove opacity for spotify
      windowrule = opacity 1.0 override 1.0 override, ^(electron)$        # Remove opacity for electron apps
      windowrulev2 = opacity 1.0 override 1.0 override, initialTitle:(Mozilla Firefox)
      windowrulev2 = opacity 1.0 override 1.0 override, initialTitle:(Firefox Developer Edition)
      windowrulev2 = opacity 1.0 override 1.0 override, initialTitle:(Spotify Premium)
      windowrulev2 = opacity 1.0 override 1.0 override, initialTitle:(LyX)
      windowrulev2 = opacity 1.0 override 1.0 override, initialTitle:(Cursor)
      windowrulev2 = opacity 1.0 override 1.0 override, initialTitle:(GNU Image Manipulation Program)

      windowrule = opacity 0.95 0.95, class:^(nvim)$
    '';
  };
}
