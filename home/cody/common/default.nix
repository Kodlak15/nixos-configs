{pkgs, ...}: {
  imports = [
    ./alacritty
    ./brave
    ./cursor
    ./kitty
    ./ghostty
    ./neovim
    ./firefox
    # ./impermanence
    ./pywal
    ./zellij
    ./yubikey
    ./git
    ./gtk
    ./nixpkgs
    ./sops
    # ./ssh
    ./swwwmgr
    ./tmux
    ./virtualization
    ./wallpaper
    ./weather
    ./zsh
  ];

  home.packages = (
    with pkgs; [
      # Version control
      codeberg-cli

      # Secret management
      sops

      # Lighttable/darkroom for photography
      darktable

      # Game development
      godot_4

      # System info
      neofetch
      nix-output-monitor
      btop
      lsof
      nvtopPackages.full
      lm_sensors
      pciutils
      usbutils

      # System tools
      bat
      eza # Disabling due to autocomplete bug (see Issue 1038)
      ripgrep
      fzf
      tree
      socat
      file
      which
      tree
      p7zip
      jq
      ydotool
      inotify-tools
      unzip

      # Torrent client
      qbittorrent

      # VPN
      mullvad-vpn

      # Blue light filter
      wlsunset

      # Wallpaper
      swww

      # Markdown viewer/editor
      glow

      # Security
      gnupg

      # Network analysis
      nmap

      # Flipper Zero software
      qflipper

      # Gaming
      webcord # discord alternative
      winetricks
      wineWowPackages.waylandFull

      # Containerisation and virtualisation
      virt-manager
      docker-compose

      # View and/or edit images
      imv
      gimp

      # Manage GoPro videos
      # gopro # (broken last I checked, at least on nixpkgs-unstable)

      # Media
      spotify
      playerctl
      ncpamixer
      pavucontrol
      vlc
      ffmpeg

      # Power and brightness
      acpi
      brightnessctl

      # File expolorer
      xfce.thunar

      # Screenshots
      grim
      slurp

      # Formatters (place these elsewhere)
      nixpkgs-fmt
      alejandra
      shfmt
    ]
  );
}
