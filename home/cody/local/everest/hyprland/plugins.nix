{
  pkgs,
  inputs,
  ...
}: {
  home.packages = [
    inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
  ];
  wayland.windowManager.hyprland = {
    plugins = [
      inputs.hyprcursor.packages.${pkgs.system}.default
    ];
  };
}
