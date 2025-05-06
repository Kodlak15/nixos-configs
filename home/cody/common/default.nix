{pkgs, ...}: {
  imports = [
    ./alacritty
    ./brave
    ./kitty
    ./ghostty
    ./neovim
    # ./impermanence
    ./pywal
    # ./ollama
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
    ./vscode
    ./zsh
    ./godot
  ];

  home.packages = (
    with pkgs; [
      # Version control
      codeberg-cli

      # Code editors
      # code-cursor
      # windsurf

      # Secret management
      sops

      # C compiler
      gcc

      # Lighttable/darkroom for photography
      darktable

      # Game development
      # godot_4

      # blender
      blender

      # System info
      neofetch
      nix-output-monitor
      btop
      lsof
      nvtopPackages.full
      lm_sensors
      pciutils
      usbutils

      # Cloud CLI tools
      doctl

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
      mullvad-browser

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

      # View images
      imv

      # Drawing/painting/editing tools
      gimp3-with-plugins
      krita

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
