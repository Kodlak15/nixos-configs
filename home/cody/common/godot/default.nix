{pkgs, ...}: {
  imports = [
    ../../../../modules/home-manager/godot.nix
  ];

  home.packages = [pkgs.godot];

  # NOTE: home manager module was causing more friction than what it's worth
  # programs.godot = {
  #   enable = true;
  #   settings = {
  #     interface.theme = {
  #       preset = "Custom";
  #       # Ayu Dark
  #       base_color = {
  #         red = 13.0;
  #         green = 16.0;
  #         blue = 23.0;
  #         alpha = 1.0;
  #       };
  #       accent_color = {
  #         red = 230.0;
  #         green = 180.0;
  #         blue = 80.0;
  #         alpha = 1.0;
  #       };
  #     };
  #     run.platforms.linuxbsd.preferWayland = true;
  #   };
  # };
}
