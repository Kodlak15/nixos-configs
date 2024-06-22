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
      flake = {
        path = lib.mkOption {
          type = lib.types.string;
          default = "";
        };
        url = lib.mkOption {
          type = lib.types.string;
          default = "";
        };
      };
      nixos.name = lib.mkOption {
        type = lib.types.string;
        default = "nixos";
      };
      home.user = lib.mkOption {
        type = lib.types.string;
        default = "user";
      };
      disks = {
        encryption = {
          enable = lib.mkOption {
            type = lib.types.bool;
            default = false;
          };
          label = lib.mkOption {
            type = lib.types.string;
            default = "NIXOS";
          };
          mapping = lib.mkOption {
            type = lib.types.string;
            default = "nixos-crypt";
          };
          smartcard = {
            enable = lib.mkOption {
              type = lib.types.bool;
              default = false;
            };
            slot = lib.mkOption {
              type = lib.types.ints.between 1 2;
            };
            saltLength = lib.mkOption {
              type = lib.types.ints.between 16 64;
              default = 16;
            };
            keyLength = lib.mkOption {
              type = lib.types.int;
              default = 512;
            };
            iterations = lib.mkOption {
              type = lib.types.int;
              default = 1000000;
            };
            cipher = lib.mkOption {
              type = lib.types.string;
              default = "aes-xts-plain64";
            };
            hash = lib.mkOption {
              type = lib.types.string;
              default = "sha512";
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
          flake:
            path: ${systems.flake.path}
            url: ${systems.flake.url}
          nixos:
            name: ${systems.nixos.name}
          home:
            user: ${systems.home.user}
          disks:
            encryption:
              enable: ${boolConvert systems.disks.encryption.enable}
              label: ${systems.disks.encryption.label}
              mapping: ${systems.disks.encryption.mapping}
              smartcard:
                enable: ${boolConvert systems.disks.encryption.smartcard.enable}
                slot: ${builtins.toString systems.disks.encryption.smartcard.slot}
                salt_length: ${builtins.toString (systems.disks.encryption.smartcard.saltLength)}
                key_length: ${builtins.toString systems.disks.encryption.smartcard.keyLength}
                iterations: ${builtins.toString systems.disks.encryption.smartcard.iterations}
                cipher: ${systems.disks.encryption.smartcard.cipher}
                hash: ${systems.disks.encryption.smartcard.hash}
            root:
              label: ${systems.disks.root.label}
              size: ${builtins.toString (rootSize systems.disks.root.size)}
              filesystem: ${systems.disks.root.filesystem}
            boot:
              label: ${systems.disks.boot.label}
              size: ${builtins.toString systems.disks.boot.size}
          jobs: ${builtins.toString systems.jobs}
      '';
    };

    home.packages = [
      inputs.powder.packages.${pkgs.system}.default
    ];
  };
}
