{pkgs, ...}: {
  home.packages = with pkgs; [zathura];

  xdg.configFile."zathura/zathurarc".source = ./zathurarc;
}
