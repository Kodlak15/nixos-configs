{pkgs, ...}: {
  gtk = {
    enable = true;
    theme = {
      # To see options for 'name' attribute see ~/.nix-profile/share/themes
      name = "Ayu-Dark";
      package = pkgs.ayu-theme-gtk;
    };
    iconTheme = {
      # To see options for 'name' attribute see ~/.nix-profile/share/icons
      name = "Ayu-Dark";
      package = pkgs.ayu-theme-gtk;
    };
    cursorTheme = {
      name = "Ayu-Dark";
      package = pkgs.ayu-theme-gtk;
      # name = "Bibata-Modern-Classic";
      # package = pkgs.bibata-cursors;
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
