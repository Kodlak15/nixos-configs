{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: let
  rootPart = "/dev/disk/by-label/ROOT";
in {
  imports = [
    ./hardware-configuration.nix
    inputs.sops-nix.nixosModules.sops
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  networking.hostName = "morrowind";

  fileSystems = {
    "/" = {
      device = rootPart;
      fsType = "btrfs";
      options = ["subvol=@"];
    };
    "/home" = {
      device = rootPart;
      fsType = "btrfs";
      options = ["subvol=@home"];
    };
    "/tmp" = {
      device = rootPart;
      fsType = "btrfs";
      options = ["subvol=@tmp"];
    };
    "/var" = {
      device = rootPart;
      fsType = "btrfs";
      options = ["subvol=@var"];
    };
  };

  swapDevices = [];

  # sops = {
  #   age.keyFile = "/home/cody/.config/sops/age/keys.txt";
  #   secrets = {
  #     "proxyPass" = {
  #       sopsFile = ./secrets.yaml;
  #     };
  #   };
  # };

  environment.systemPackages = with pkgs; [
    neovim
    tmux
    age
  ];

  boot = {
    loader = {
      grub = {
        enable = true;
        device = "/dev/sda";
      };
    };
  };

  services = {
    nginx = {
      enable = true;
      logError = "stderr debug";
      recommendedProxySettings = true;
      recommendedTlsSettings = true;
      virtualHosts."cascade-botanicals.com" = {
        enableACME = true;
        forceSSL = true;
        locations = {
          "/" = {
            proxyPass = "http://127.0.0.1:3000";
          };
        };
      };
    };
    openssh = {
      enable = true;
      ports = [22];
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
      };
    };
  };

  security = {
    acme = {
      acceptTerms = true;
      defaults = {
        email = "stanlcod15@protonmail.com";
      };
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

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [80 443 62621];
  };

  system.stateVersion = "24.11";
}
