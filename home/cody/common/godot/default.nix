{
  imports = [
    ../../../../modules/home-manager/godot.nix
  ];

  programs.godot = {
    enable = true;
    settings = {
      interface.theme = {
        preset = "Custom";
        base_color = {
          red = 34.0;
          green = 41.0;
          blue = 54.0;
          alpha = 1.0;
        };
        accent_color = {
          red = 255.0;
          green = 204.0;
          blue = 102.0;
          alpha = 1.0;
        };
      };
      run.platforms.linuxbsd.preferWayland = true;
    };
  };
}
