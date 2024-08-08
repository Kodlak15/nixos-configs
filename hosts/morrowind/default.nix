{
  pkgs,
  lib,
  ...
}: {
  nix.settings.experimental-features = ["nix-command" "flakes"];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  networking.hostName = "morrowind";

  environment.systemPackages = with pkgs; [
    neovim
    neofetch
    tmux
  ];

  services = {
    nginx = {
      enable = true;
      logError = "stderr debug";
      recommendedProxySettings = true;
      recommendedTlsSettings = true;
      virtualHosts."cascade-botanicals.com" = {
        ##
        enableACME = true;
        forceSSL = true;
        ##
        locations = {
          "/" = {
            proxyPass = "http://127.0.0.1:3000";
          };
        };
      };
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

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [80 443];
  };

  system.stateVersion = "24.11";
}
