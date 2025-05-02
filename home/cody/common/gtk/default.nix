{pkgs, ...}: {
  gtk = {
    enable = true;
    theme = {
      # To see options for 'name' attribute see ~/.nix-profile/share/themes
      # name = "rose-pine";
      name = "Ayu-Dark";
      # package = pkgs.rose-pine-gtk-theme;
      package = pkgs.ayu-theme-gtk;
    };
    iconTheme = {
      # To see options for 'name' attribute see ~/.nix-profile/share/icons
      # name = "rose-pine";
      name = "Ayu-Dark";
      # package = pkgs.rose-pine-icon-theme;
      package = pkgs.ayu-theme-gtk;
    };
    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 16;
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 16;
  };
}
