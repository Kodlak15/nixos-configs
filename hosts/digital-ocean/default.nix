{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    "${inputs.nixpkgs}/nixos/modules/virtualisation/digital-ocean-image.nix"
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  virtualisation.digitalOceanImage.compressionMethod = "bzip2";

  environment.systemPackages = with pkgs; [
    neovim
    neofetch
  ];

  users.users = {
    root = {
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHwaOrqTJ6Xq8qU3y/Vn02tHMUZJISNRA/fLAVfYCN21 openpgp:0x344DA983"
      ];
    };
  };

  system.stateVersion = "24.11";
}
