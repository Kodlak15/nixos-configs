{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./disk-config.nix
    ./hardware-configuration.nix
  ];

  nix.settings = {
    experimental-features = ["nix-command" "flakes" "pipe-operators"];
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      # allow unfree packages
    ];

  networking = {
    hostName = "rift";
    networkmanager.enable = true;
    firewall = {
      enable = true;
    };
  };

  programs = {
    zsh.enable = true;
  };

  services = {
    openssh = {
      enable = true;
      ports = [22];
      settings = {
        PasswordAuthentication = true;
      };
    };
    pulseaudio.enable = false;
    dbus.enable = true;
    xserver = {
      enable = true;
      desktopManager = {
        xterm.enable = true;
        xfce.enable = true;
      };
    };
    displayManager.defaultSession = "xfce";
  };

  environment = {
    shells = with pkgs; [zsh];
    variables = {
      EDITOR = "${pkgs.neovim}";
    };
  };

  time.timeZone = "US/Pacific";
  i18n.defaultLocale = "en_US.UTF-8";

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      grub = {
        enable = true;
        devices = ["nodev"];
        efiSupport = true;
        efiInstallAsRemovable = true;
        configurationLimit = 20;
      };
    };
  };

  environment = {
    systemPackages = with pkgs; [
      wget
      curl
      git
      gnupg
      pass
      nix-prefetch-git
      gnumake
      bc
      killall
      age
    ];
  };

  users = {
    users.cody = {
      hashedPassword = "$y$j9T$4rqef9eP7tE8/VoMw/B7S/$.ac9xBZtHsjmkz0YrBJn84uF5ot4sJ7iYTNQ/9VxNi6";
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "audio"
        "video"
        "render"
        "input"
        "docker"
        "libvirtd"
        "wireshark"
        "usb"
        "plugdev"
        "networkmanager"
        "scanner"
        "lp"
        "bluetooth"
      ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHwaOrqTJ6Xq8qU3y/Vn02tHMUZJISNRA/fLAVfYCN21"
      ];
    };
    users.root = {
      initialHashedPassword = "$y$j9T$C0KKoJoaUpeRwDYaW5dj20$.tvNBzhUxrWJAI2BXj7YtpKgJLez03IS6WMeel26Zr/";
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHwaOrqTJ6Xq8qU3y/Vn02tHMUZJISNRA/fLAVfYCN21"
      ];
    };
    defaultUserShell = pkgs.zsh;
  };

  system.stateVersion = "23.05";
}
