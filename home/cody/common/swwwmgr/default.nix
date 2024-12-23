{inputs, ...}: {
  imports = [inputs.swwwmgr.homeManagerModules.default];

  programs.swwwmgr = {
    enable = true;
    transition = {
      angle = "45";
      duration = "3";
      position = "center";
      step = "90";
      type = "fade";
    };
  };
}
