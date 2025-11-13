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
    ./vscode
    ./zsh
    ./godot
    ./systemd
    ./claude-code
    ./zathura
    ./eww
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
      sops
      gcc
      neofetch
      nix-output-monitor
      btop
      lsof
      nvtopPackages.full
      lm_sensors
      pciutils
      usbutils
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
      qbittorrent
      mullvad-vpn
      mullvad-browser
      glow
      gnupg
      nmap
      qFlipper
      webcord # discord alternative
      winetricks
      wineWowPackages.waylandFull
      virt-manager
      docker-compose
      imv # image viewer
      gimp3-with-plugins
      krita
      spotify
      playerctl
      ncpamixer
      pavucontrol
      vlc
      ffmpeg
      acpi
      brightnessctl
      hyprsunset
      wlsunset
      xfce.thunar
      grim
      slurp
      nixpkgs-fmt # nix formatter
      alejandra # (better) nix formatter
      shfmt # shell formatter (can't remember why this was here tbh, may remove)
    ]
  );
}
