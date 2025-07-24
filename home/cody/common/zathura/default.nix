{pkgs, ...}: {
  home.packages = with pkgs; [zathura];

  xdg.configFile.zathura.source = ./zathurarc;
}
