{
  pkgs,
  lib,
  ...
}: {
  nix.settings.experimental-features = ["nix-command" "flakes"];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  networking.hostName = "alduin";

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
        # enableACME = true;
        # forceSSL = true;
        ##
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
      # authentication = pkgs.lib.mkOverride 10 ''
      #   #Type #Database #User #auth-method
      #   local all       all   trust
      #   #type #database DBuser origin-address auth-method
      #   # ipv4
      #   host  all      all     127.0.0.1/32   trust
      #   # ipv6
      #   host  all       all     ::1/128        trust
      # '';
      # authentication = pkgs.lib.mkOverride 10 ''
      #   #type database  DBuser  auth-method
      #   local all       all     trust
      #   host  all       all     127.0.0.1/32 scram-sha-256
      #   host  all       all     ::1/128 scram-sha-256
      # '';
      authentication = pkgs.lib.mkOverride 10 ''
        #type database  DBuser  auth-method
        local all       all     trust
        host  all       all     192.168.122.1/32 trust
        host  all       all     172.17.0.0/16    trust
        host  all       all     ::1/128          trust
      '';
      enableTCPIP = true;
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
    allowedTCPPorts = [80 443 5432];
  };

  system.stateVersion = "24.11";
}
