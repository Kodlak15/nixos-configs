# A simple NixOS module to include in the Digital Ocean image
{
  nixpkgs.hostPlatform = "x86_64-linux";

  nix.settings.experimental-features = ["nix-command" "flakes"];

  services = {
    openssh = {
      enable = true;
      settings.PasswordAuthentication = false;
    };
  };

  users = {
    users = {
      root = {
        openssh.authorizedKeys.keys = [
          "ssh-ed25519AAAAC3NzaC1lZDI1NTE5AAAAIHwaOrqTJ6Xq8qU3y/Vn02tHMUZJISNRA/fLAVfYCN21"
        ];
      };
    };
  };

  virtualisation.digitalOceanImage.compressionMethod = "bzip2";

  swapDevices = [
    {
      device = "/swap/swapfile";
      size = 1024 * 2; # 2 GB
    }
  ];

  system.stateVersion = "23.05";
}
