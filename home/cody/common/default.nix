{pkgs, ...}: {
  imports = [
    ./brave
    ./ghostty
    ./neovim
    ./zellij
    ./yubikey
    ./git
    ./gtk
    ./nixpkgs
    ./sops
    ./swwwmgr
    ./virtualization
    ./wallpaper
    ./weather
    ./vscode
    ./zsh
    ./godot
    ./systemd
    ./opencode
    ./claude-code
    ./webull
    ./zathura
  ];

  home.shellAliases = {
    NIXCFG = "$HOME/nix/flakes/nixos/";
    ls = "eza -l";
    lsa = "eza -la";
    e = "fzedit";
    o = "fzopen";
    z = "zellij";
    nd = "nix develop";
    nb = "nix build";
    nr = "nix run";
    screenshot = "$HOME/nix/flakes/nixos/scripts/screenshot.sh";
    cat = "bat";
    cursor = "cursor --enable-features=UseOzonePlatform --ozone-platform=wayland";
  };

  home.packages = (
    with pkgs; [
      # Version control
      codeberg-cli

      # Secret management
      sops

      # C compiler
      gcc

      # Art and Graphics
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
      eza
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
      hyprsunset

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
