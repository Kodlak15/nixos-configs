{inputs, ...}: {
  imports = [inputs.swwwmgr.homeManagerModules.default];

  programs.swwwmgr = {
    enable = true;
    transition = {
      angle = "45";
      # duration = "3";
      duration = "2";
      position = "center";
      step = "90";
      type = "grow";
    };
    hooks = {
      after_set = [
        # something needs to run here or else the program breaks (obviously needs to be fixed)
        "echo done"
      ];
    };
  };
}
