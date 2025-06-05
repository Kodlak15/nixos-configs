{
  pkgs,
  lib,
  config,
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
      "nvidia-x11"
      "nvidia-settings"
      "nvidia-persistenced"
      "libXNVCtrl"
      "steam"
      "steam-original"
      "steam-run"
      "cudatoolkit"
    ];

  networking = {
    hostName = "cyrodil";
    networkmanager.enable = true;
    firewall = {
      enable = true;
    };
  };

  sops = {
    age = {
      sshKeyPaths = ["/persist/etc/ssh/ssh_host_ed25519_key"];
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = true;
    };
    secrets = {
      anthropic_api_key = {
        sopsFile = ./secrets.yaml;
        neededForUsers = true;
      };
    };
  };

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
    openssh = {
      enable = true;
      ports = [22];
      settings = {
        PasswordAuthentication = false;
      };
      # ISSUE: https://github.com/nix-community/impermanence/issues/192
      # When using impermanence, after installing with nixos-anywhere
      # and disko, /etc/ssh/sshd_config is not generated. This prevents the
      # ssh daemon from starting, and makes it impossible to ssh into the
      # new system. Manually adding the host keys as seen below is a workaround
      # for this issue.
      hostKeys = [
        {
          type = "ed25519";
          path = "/persist/etc/ssh/ssh_host_ed25519_key";
        }
        {
          type = "rsa";
          bits = 4096;
          path = "/persist/etc/ssh/ssh_host_rsa_key";
        }
      ];
    };
    ollama = {
      enable = true;
      acceleration = "cuda";
      loadModels = [
        "deepseek-r1"
        "deepseek-r1:14b"
        "deepseek-r1:32b"
        "llama3.2"
      ];
    };
    open-webui = {
      enable = true; # see issue above
      openFirewall = true;
      port = 8888;
    };
    pulseaudio.enable = false;
    dbus.enable = true;
    printing = {
      enable = true;
      drivers = with pkgs; [
        gutenprint
      ];
      browsedConf = ''
        BrowseDNSSDSubTypes _cups,_print
        BrowseLocalProtocols all
        BrowseRemoteProtocols all
        CreateIPPPrinterQueues All

        BrowseProtocols all
      '';
    };
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
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
    pcscd.enable = true; # Enable to change settings on sc, disable to use w/ gpg
    mullvad-vpn.enable = true;
    udev.packages = with pkgs; [
      yubikey-personalization
    ];
    getty.autologinUser = "cody";
    blueman.enable = true;
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

  fonts.packages = with pkgs;
    [
      # nerd-fonts.fira-code
      # nerd-fonts.droid-sans-mono
      texlivePackages.lm-math
    ]
    ++ (builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts));

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
        useOSProber = true;
        configurationLimit = 20;
      };
    };
    initrd = {
      # luks.devices."/dev/disk/by-partlabel/cyrodil-luks".fido2.passwordLess = true;
      postDeviceCommands = lib.mkAfter ''
        mkdir /btrfs_tmp
        mount /dev/mapper/root /btrfs_tmp
        if [[ -e /btrfs_tmp/root ]]; then
            mkdir -p /btrfs_tmp/old_roots
            timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
            mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
        fi

        delete_subvolume_recursively() {
            IFS=$'\n'
            for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
                delete_subvolume_recursively "/btrfs_tmp/$i"
            done
            btrfs subvolume delete "$1"
        }

        for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +30); do
            delete_subvolume_recursively "$i"
        done

        btrfs subvolume create /btrfs_tmp/root
        umount /btrfs_tmp
      '';
    };
  };

  hardware = {
    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      # open = true;
      open = false;
      nvidiaSettings = true;
      # package = config.boot.kernelPackages.nvidiaPackages.stable;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
    };
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  virtualisation = {
    docker.enable = true;
    libvirtd = {
      enable = true;
      qemu.ovmf.enable = true;
      onBoot = "ignore";
      onShutdown = "shutdown";
    };
  };

  programs.dconf = {
    enable = true;
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
      virtiofsd
      fido2luks
      nvidia-container-toolkit
    ];
    persistence."/persist" = {
      enable = true;
      hideMounts = true;
      directories = [
        "/var/log"
        "/var/lib"
        "/var/cache/mullvad-vpn"
        "/etc/mullvad-vpn"
        "/etc/NetworkManager/system-connections"
      ];
    };
  };

  users = {
    # mutableUsers = false;
    users.cody = {
      # hashedPasswordFile = config.sops.secrets.password_hash.path;
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
