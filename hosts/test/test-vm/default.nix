{
  pkgs,
  lib,
  ...
}: let
  username = "user";
  version = "24.05";
  luks = "nixos-crypt";
  luksPart = "/dev/disk/by-label/NIXOS";
  rootPart = "/dev/disk/by-label/ROOT";
  bootPart = "/dev/disk/by-label/EFI-NIXOS";
in {
  imports = [
    ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # boot.initrd.luks.devices.${luks}.device = luksPart;

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
    initrd = {
      kernelModules = ["vfat" "nls_cp437" "nls_iso8859-1" "usbhid"];
      luks = {
        yubikeySupport = true;
        devices.${luks} = {
          device = luksPart;
          yubikey = {
            slot = 2;
            twoFactor = true;
            gracePeriod = 30;
            keyLength = 64;
            saltLength = 16;
            storage = {
              device = bootPart;
              fsType = "vfat";
              path = "/crypt-storage/default";
            };
          };
        };
      };
    };
  };

  networking.hostName = "default";
  networking.networkmanager.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  users.users.${username} = {
    isNormalUser = true;
    initialPassword = "apple";
    extraGroups = ["wheel"];
    packages = with pkgs; [
      gnumake
      git
      tree
    ];
  };

  environment.systemPackages = with pkgs; [
    neovim
    wget
    neofetch
    btop
  ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Yubikey support
  hardware.gpgSmartcards.enable = true;

  services.openssh.enable = true;

  # Do not change this value!
  system.stateVersion = "${version}";
}
