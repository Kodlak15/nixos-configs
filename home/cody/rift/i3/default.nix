{
  pkgs,
  lib,
  config,
  ...
}: {
  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;
    config = {
      modifier = "Mod4";
      gaps = {
        inner = 4;
        outer = 2;
      };
      keybindings = let
        modifier = config.xsession.windowManager.i3.config.modifier;
      in
        lib.mkOptionDefault {
          "${modifier}+Return" = "exec kitty";
          "${modifier}+b" = "exec firefox";
          "${modifier}+Shift+q" = "kill";
          "${modifier}+d" = "exec ${pkgs.dmenu}/bin/dmenu_run";
        };
    };
  };
}
