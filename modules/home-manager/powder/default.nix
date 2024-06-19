{
  lib,
  config,
  ...
}: let
  inherit (lib) mkOption mkIf types;
  cfg = config.powder;
in {
  options.powder = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Enables powder
      '';
    };
    config = mkOption {
      type = types.string;
      default = '''';
      description = ''
        The powder yaml configuration
      '';
    };
  };

  config = mkIf cfg.enable {
    xdg.configFile."powder/config.yaml".text = ''

    '';
  };
}
