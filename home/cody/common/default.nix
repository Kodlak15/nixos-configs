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
    ./zathura
    ./eww
    ./opencode
    ./firefox
    ./obsidian
  ];

  home.shellAliases = {
    ls = "eza -l";
    lsa = "eza -la";
    e = "fzedit";
    o = "fzopen";
    z = "zellij";
    nd = "nix develop";
    nb = "nix build";
    nr = "nix run";
    # cat = "bat"; # NOTE this was kind of annoying, so I disabled
  };

  home.packages = (
    with pkgs; [
      example # just for testing custom package loading
      sops
      gcc
      fastfetch
      xdg-utils
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
      # claude-code # ISSUE: https://github.com/NixOS/nixpkgs/issues/507045
      glow
      gnupg
      nmap
      qFlipper
      webcord
      winetricks
      wineWow64Packages.waylandFull
      virt-manager
      docker-compose
      imv # image viewer
      gimp3-with-plugins
      # krita # ISSUE https://github.com/NixOS/nixpkgs/issues/485826
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
      thunar
      grim
      slurp
      nixpkgs-fmt # nix formatter
      alejandra # (better) nix formatter
      shfmt # shell formatter (can't remember why this was here tbh, may remove)
      dolphin-emu
      tradingview
    ]
  );
}
