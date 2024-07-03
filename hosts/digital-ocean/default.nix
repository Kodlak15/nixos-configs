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

  system.stateVersion = "24.11";
}
