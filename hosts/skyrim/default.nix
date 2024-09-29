{
  pkgs,
  lib,
  inputs,
  ...
}: {
  nix.settings.experimental-features = ["nix-command" "flakes"];

  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "nvidia-x11"
      "nvidia-settings"
      "nvidia-persistenced"
      "libXNVCtrl"
      "steam"
      "steam-original"
      "steam-run"
      "cudatoolkit"
    ];

  boot.kernelParams = ["amd_iommu=on"];

  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    zsh = {
      enable = true;
    };
    wireshark = {
      enable = true;
      package = pkgs.wireshark-qt;
    };
    ssh.startAgent = false; # TODO may need to delete later
  };

  services = {
    openssh.enable = true;
    dbus.enable = true;
    printing.enable = true;
    libinput.enable = true;
    xserver = {
      videoDrivers = ["nvidia"];
    };
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };
    pcscd.enable = false; # Enable to change settings on sc, disable to use w/ gpg
    mullvad-vpn.enable = true;
    udev.packages = with pkgs; [
      yubikey-personalization
    ];
    getty.autologinUser = "cody";
  };

  security = {
    rtkit.enable = true;
  };

  users = {
    defaultUserShell = pkgs.zsh;
    users.root = {
      initialHashedPassword = "$y$j9T$cVBuDErrQuq9PhUTj94mZ0$SNaVM8HEx1AHJgZEFvekLmhAWYm0OhDESkmfRmNLw89";
    };
  };

  environment = {
    shells = with pkgs; [zsh];
    variables = {
      EDITOR = "${pkgs.neovim}";
    };
    shellInit = ''
      gpg-connect-agent /bye
      export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
    '';
  };

  fonts.packages = with pkgs; [
    nerdfonts
  ];

  networking = {
    networkmanager.enable = true;
    firewall = {
      enable = true;
    };
  };

  time.timeZone = "US/Pacific";

  i18n.defaultLocale = "en_US.UTF-8";

  hardware = {
    gpgSmartcards.enable = true;
    pulseaudio.enable = false;
  };

  virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;
  };

  programs.dconf = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    tmux
    wget
    curl
    git
    gh
    gnupg
    pass
    nix-prefetch-git
    gnumake
    bc
    killall
    age
  ];
}
