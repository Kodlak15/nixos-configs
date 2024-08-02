{
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    "${inputs.nixpkgs}/nixos/modules/virtualisation/digital-ocean-image.nix"
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  virtualisation.digitalOceanImage.compressionMethod = "bzip2";

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  networking.hostName = "alduin";

  environment.systemPackages = with pkgs; [
    neovim
    neofetch
  ];

  # TODO add option to flake to rebuild droplet so I don't need to rebuild this each time
  services = {
    nginx = {
      enable = true;
      virtualHosts."my-domain.com" = {
        # addSSL = true;
        # enableACME = true;
        locations = {
          "/" = {
            proxyPass = "http://127.0.0.1:3000";
          };
        };
      };
    };
    postgresql = {
      enable = true;
      ensureDatabases = ["mydb"];
      authentication = pkgs.lib.mkOverride 10 ''
        #Type #Database #User #auth-method
        local all       all   trust
      '';
    };
  };

  security = {
    acme = {
      defaults = {
        email = "stanlcod15@protonmail.com";
      };
      acceptTerms = true;
    };
  };

  virtualisation = {
    docker = {
      enable = true;
    };
  };

  users.users = {
    root = {
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHwaOrqTJ6Xq8qU3y/Vn02tHMUZJISNRA/fLAVfYCN21 openpgp:0x344DA983"
      ];
    };
  };

  system.stateVersion = "24.11";
}
