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
      windowrule = opacity 0.95 0.95, class:^(nvim)$                      # Reduce opacity for neovim
    '';
  };
}
