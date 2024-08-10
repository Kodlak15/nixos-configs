{
  pkgs,
  pkgs-stable,
  ...
}: let
  stable = with pkgs-stable; [eza]; # Using due to autocomplete bug (see Issue 1038)
  unstable = with pkgs; [
    # Browsers
    brave

    # Secret management
    sops

    # Debugging and reverse engineering
    gdb

    # LLM Clients
    gpt4all

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
    # eza # Disabling due to autocomplete bug (see Issue 1038)
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
    gopro

    # Media
    spotify
    playerctl
    pavucontrol
    vlc
    ffmpeg

    # Screen recording/streaming
    obs-studio

    # Power and brightness
    acpi
    brightnessctl

    # File expolorer
    xfce.thunar

    # Screenshots
    grim
    slurp

    # Pywal (is this needed???)
    # python311Packages.colorthief

    # Neovim/Vim plugins (place in nvim config???)
    # vimPlugins.nvim-treesitter-parsers.templ

    # Language servers (place these elsewhere)
    # nodePackages.bash-language-server

    # Formatters (place these elsewhere)
    nixpkgs-fmt
    alejandra
    shfmt
  ];
in {
  home.packages = unstable ++ stable;
}
