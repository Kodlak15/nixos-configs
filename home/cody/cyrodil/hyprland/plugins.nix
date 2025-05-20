{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [hyprsunset];

  wayland.windowManager.hyprland = {
    plugins = [];
  };
}
