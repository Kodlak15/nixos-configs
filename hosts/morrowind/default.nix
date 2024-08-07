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
      # virtualHosts."cascade-botanicals.com" = {
      virtualHosts."localhost" = {
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
    # postgresql = {
    #   enable = true;
    #   ensureDatabases = ["mydb"];
    #   authentication = pkgs.lib.mkOverride 10 ''
    #     #type database  DBuser  auth-method
    #     local all       all     trust
    #     host  all       all     192.168.122.1/32 trust
    #     host  all       all     172.17.0.0/16    trust
    #     host  all       all     ::1/128          trust
    #   '';
    #   enableTCPIP = true;
    # };
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
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCi4MImwV8uX879jo0aBojBjMx8fXky/Md5qS/E/KPGPzr5SsGHs5RYuOnHEQj+gqCT83MG26E9pJo9OhFzencuXc4nu8x/O6wXN27a2YGs0Boz/31TkvIdS4RGvxL6nWSXNoNNzrf6y0v2qCIqCVB/G8jRRkLUQ0npiFYSZmNugnD3ZvH3pJJ2ePHo13zMvqFm1+enkfG+gR6/EfaPAjKIgrX08hWiB54fwYPlir9Jr55FmbXPvo5beUr1gfS1d/+TadEF11tDsHyE9Ty4kMbPR/maEzzPT6o9/TfTI4l0JN7EmwvGfQayBAFQCXcFas3xbI/SoPAwSS0xHAQgZYKL coolify-generated-ssh-key"
      ];
    };
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [80 443 5432];
  };

  system.stateVersion = "24.11";
}
