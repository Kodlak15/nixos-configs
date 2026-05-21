{
  programs.eww = {
    enable = true;
    yuckConfig = builtins.readFile ./config/eww.yuck;
    scssConfig = builtins.readFile ./config/eww.scss;
  };

  # The new eww module only manages eww.yuck and eww.scss. Our entrypoints
  # `include` files from these subdirectories, so symlink them alongside.
  xdg.configFile = {
    "eww/modules".source = ./config/modules;
    "eww/windows".source = ./config/windows;
    "eww/styles".source = ./config/styles;
    "eww/scripts".source = ./config/scripts;
    "eww/images".source = ./config/images;
  };
}
