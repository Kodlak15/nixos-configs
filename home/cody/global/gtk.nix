{pkgs, ...}: {
  gtk = {
    enable = true;
    theme = {
      # To see options for 'name' attribute see ~/.nix-profile/share/themes
      name = "rose-pine";
      package = pkgs.rose-pine-gtk-theme;
    };
    iconTheme = {
      # To see options for 'name' attribute see ~/.nix-profile/share/icons
      name = "rose-pine";
      package = pkgs.rose-pine-icon-theme;
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    name = "Catppuccin-Mocha-Dark-Cursors";
    package = pkgs.catppuccin-cursors.mochaDark;
  };
}
