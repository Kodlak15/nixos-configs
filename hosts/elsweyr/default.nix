{
  pkgs,
  config,
  inputs,
  ...
}: {
  nixpkgs.hostPlatform = "x86_64-linux";

  nix.settings.experimental-features = ["nix-command" "flakes"];

  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    validateSopsFiles = false;
    age = {
      sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = true;
    };
    secrets = {
      domain = {
        sopsFile = ./secrets.yaml;
      };
      host_ip = {
        sopsFile = ./secrets.yaml;
      };
      host_port = {
        sopsFile = ./secrets.yaml;
      };
      cloudflare_zone_token = {
        sopsFile = ./secrets.yaml;
      };
      cloudflare_dns_token = {
        sopsFile = ./secrets.yaml;
      };
    };
    templates = {
      "caddy_config" = {
        owner = config.services.caddy.user;
        content = ''
          ${config.sops.placeholder.domain} {
            tls {
              dns cloudflare {
                zone_token ${config.sops.placeholder.cloudflare_zone_token}
                api_token ${config.sops.placeholder.cloudflare_dns_token}
              }
            }
            reverse_proxy ${config.sops.placeholder.host_ip}:${config.sops.placeholder.host_port} {
              header_up X-Real-IP {remote_host}
              header_up X-Forwarded-For {remote_host}
              header_up X-Forwarded-Proto {scheme}
            }
          }
        '';
      };
    };
  };

  services = {
    openssh = {
      enable = true;
      settings.PasswordAuthentication = false;
    };
    caddy = {
      enable = true;
      configFile = config.sops.templates."caddy_config".path;
    };
  };

  users = {
    users = {
      root = {
        openssh.authorizedKeys.keys = [
          "ssh-ed25519AAAAC3NzaC1lZDI1NTE5AAAAIHwaOrqTJ6Xq8qU3y/Vn02tHMUZJISNRA/fLAVfYCN21"
        ];
      };
      caddy = {
        isSystemUser = true;
        group = "caddy";
        openssh.authorizedKeys.keys = [
          "ssh-ed25519AAAAC3NzaC1lZDI1NTE5AAAAIHwaOrqTJ6Xq8qU3y/Vn02tHMUZJISNRA/fLAVfYCN21"
        ];
      };
    };
  };

  virtualisation = {
    docker = {
      enable = true;
    };
    digitalOceanImage.compressionMethod = "bzip2";
  };

  environment = {
    systemPackages = with pkgs; [
      neovim
    ];
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [80 443];
  };

  system.stateVersion = "23.05";
}
