{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: let
  cfg = config.powder;
  systems = cfg.systems;
  boolConvert = b:
    if b
    then "1"
    else "0";
  rootSize = size:
    if size == null
    then -1
    else size;
in {
  options.powder = {
    enable = lib.mkEnableOption "Enable powder";
    systems = {
      default = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
      flake = lib.mkOption {
        type = lib.types.path;
        default = /etc/nixos;
      };
      nixos.name = lib.mkOption {
        type = lib.types.string;
        default = "nixos";
      };
      hm.user = lib.mkOption {
        type = lib.types.string;
        default = "user";
      };
      install = {
        disks = {
          encryption = {
            enable = lib.mkOption {
              type = lib.types.bool;
              default = false;
            };
            label = lib.mkOption {
              type = lib.types.string;
              default = "NIXOS-CRYPT";
            };
            smartcard = {
              enable = lib.mkOption {
                type = lib.types.bool;
                default = false;
              };
              slot = lib.mkOption {
                type = lib.types.ints.between 1 2;
              };
            };
          };
          root = {
            label = lib.mkOption {
              type = lib.types.string;
              default = "NIXOS";
            };
            size = lib.mkOption {
              type = lib.types.nullOr lib.types.int;
              default = null;
            };
            filesystem = lib.mkOption {
              type = lib.types.string;
              default = "btrfs";
            };
          };
          boot = {
            label = lib.mkOption {
              type = lib.types.string;
              default = "EFI-NIXOS";
            };
            size = lib.mkOption {
              type = lib.types.int;
              default = 512;
            };
          };
        };
      };
      jobs = lib.mkOption {
        # TODO find better way to constrain
        type = lib.types.ints.between 1 16;
        default = 1;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    xdg.configFile = {
      "powder/config.yaml".text = ''
        example:
          default: ${boolConvert systems.default}
          flake: ${systems.flake}
          nixos:
            name: ${systems.nixos.name}
          hm:
            user: ${systems.hm.user}
        install:
          disks:
            encryption:
              enable: ${boolConvert systems.install.disks.encryption.enable}
              label: ${systems.install.disks.encryption.label}
              smartcard:
                enable: ${boolConvert systems.install.disks.encryption.smartcard.enable}
                slot: ${builtins.toString systems.install.disks.encryption.smartcard.slot}
            root:
              label: ${systems.install.disks.root.label}
              size: ${builtins.toString (rootSize systems.install.disks.root.size)}
              filesystem: ${systems.install.disks.root.filesystem}
            boot:
              label: ${systems.install.disks.boot.label}
              size: ${builtins.toString systems.install.disks.boot.size}
        jobs: ${builtins.toString systems.jobs}
      '';
    };

    home.packages = [
      inputs.powder.packages.${pkgs.system}.default
    ];
  };
}
