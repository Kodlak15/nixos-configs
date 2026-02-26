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
    # TODO: create custom package and add to default overlay, then use that here instead
    # screenshot = "$HOME/nix/flakes/nixos/scripts/screenshot.sh";
    cat = "bat";
  };

  home.packages = (
    with pkgs; [
      example # just for testing custom package loading
      sops
      gcc
      neofetch
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
      claude-code
      glow
      gnupg
      nmap
      qFlipper
      # webcord # discord alternative (package currently broken, disabling for now)
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
      thunar
      grim
      slurp
      nixpkgs-fmt # nix formatter
      alejandra # (better) nix formatter
      shfmt # shell formatter (can't remember why this was here tbh, may remove)
      dolphin-emu
    ]
  );
}
