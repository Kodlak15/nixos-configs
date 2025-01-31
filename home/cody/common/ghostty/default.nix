{
  pkgs,
  inputs,
  ...
}: {
  home.packages = [
    inputs.ghostty.packages.${pkgs.system}.default
  ];

  xdg.configFile = {
    "ghostty/config".text = ''
      font-family = Fira Code Nerd Font
      font-size = 12
      gtk-titlebar = false
      window-padding-x = 6
      window-padding-y = 6
    '';
  };
}
