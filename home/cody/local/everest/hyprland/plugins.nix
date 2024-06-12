{pkgs, ...}: {
  wayland.windowManager.hyprland = {
    plugins = with pkgs; [
      hyprcursor
    ];
  };
}
