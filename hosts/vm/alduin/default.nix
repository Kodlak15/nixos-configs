# TODO find a better way to organize this and the image file to avoid redundancy
{
  pkgs,
  lib,
  ...
}: let
  rootPart = "/dev/disk/by-label/ROOT";
  bootPart = "/dev/disk/by-label/EFI-NIXOS";
in {
  imports = [
    ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  networking.hostName = "alduin";

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

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };

  environment.systemPackages = with pkgs; [
    neovim
    neofetch
  ];

  services = {
    nginx = {
      enable = true;
      virtualHosts."myhost.org" = {
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
