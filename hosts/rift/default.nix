{
  pkgs,
  lib,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./disk-config.nix
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  boot = {
    loader = {
      grub = {
        enable = true;
        devices = ["nodev"];
        efiSupport = true;
        efiInstallAsRemovable = true;
      };
    };
  };

  services = {
    openssh.enable = true;
  };

  environment.systemPackages = with pkgs; [
    curl
    wget
    git
  ];

  users.users = {
    root = {
      initialHashedPassword = "$y$j9T$vVNMHVnnesyBcnbDxNQ7T/$JqywYFyoePyzWLEW822Sv2pWYyQoLJgAo.wCzurMyNC";
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN0jIg6UYuO+MSjBEcaaJXAoY3yLl7q7tqMVB0yFiqGr"
      ];
    };
  };

  system.stateVersion = "24.05";
}
