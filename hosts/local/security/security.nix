{
  pkgs,
  inputs,
  ...
}: {
  nix.settings = {
    experimental-features = ["nix-command" "nix/flakes"];
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking = {
    networkmanager.enable = true;
  };

  sound = {
    enable = true;
  };

  hardware = {
    pulseaudio.enable = true;
    opengl = {
      enable = true;
    };
  };

  users.users.anon = {
    isNormalUser = true;
    extraGroups = ["wheel" "audio" "video" "wireshark"];
    packages = with pkgs; [
      tree
    ];
  };

  environment.systemPackages = with pkgs; [
    neovim
    wget
    gnumake
    git
  ];

  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    wireshark = {
      enable = true;
      package = pkgs.wireshark-qt;
    };
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    };
  };

  services = {
    openssh.enable = true;
  };

  security = {
    polkit.enable = true;
  };
}
