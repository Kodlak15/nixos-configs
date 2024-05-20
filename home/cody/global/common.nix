{pkgs, ...}: let
  # NOTE set up this way in case stable packages are desired at any point
  unstable = with pkgs; [
    # Browsers
    librewolf
    brave
    tor-browser-bundle-bin

    # Debugging and reverse engineering
    gdb
    ghidra

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

    # Blue light filter
    wlsunset

    # Dev tools
    trunk

    # Markdown editor
    logseq

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

    # Paint
    pinta

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

    # Terminal multiplexer
    # zellij

    # Yubikey
    yubikey-personalization

    # Screenshots
    grim
    slurp

    # Pywal
    pywal
    python311Packages.colorthief

    # Neovim/Vim plugins
    # vimPlugins.friendly-snippets
    vimPlugins.nvim-treesitter-parsers.templ

    # Language servers (place these elsewhere)
    nodePackages.bash-language-server

    # Formatters (place these elsewhere)
    nixpkgs-fmt
    alejandra
    shfmt
  ];
in {
  home.packages = unstable;
}
