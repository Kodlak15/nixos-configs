{
  pkgs,
  lib,
  config,
}: let
  inherit (lib) mkOption types;
  cfg = config.powder;
in {
  options.powder = mkOption {
    enable = lib.mkEnableOption "Whether to enable powder";
    config = lib.mkIf cfg.enable {
      type = lib.types.path;
    };
  };
}
