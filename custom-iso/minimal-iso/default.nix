{
  pkgs,
  lib,
  ...
}: let
  rbtohex =
    pkgs.writeShellScriptBin
    "rbtohex"
    ''( od -An -vtx1 | tr -d ' \n' )'';
  hextorb =
    pkgs.writeShellScriptBin
    "hextorb"
    ''( tr '[:lower:]' '[:upper:]' | sed -e 's/\([0-9A-F]\{2\}\)/\\\\\\x\1/gI'| xargs printf )'';
  pbkdf2Sha512 = pkgs.callPackage ./pbkdf2-sha512.nix {};
  mountykepart = pkgs.writeShellScriptBin "mountykepart" ''
    echo "Enter 2FA password:"
    read -s USER_PASSPHRASE

    # Get the salt
    mount --mkdir "/dev/disk/by-label/EFI-NIXOS" "/mnt/boot"
    SALT="$(head -n 1 "/mnt/boot/crypt-storage/default")"

    # Calculate the LUKS key and open the LUKS partition
    CHALLENGE="$(echo -n $SALT | openssl dgst -binary -sha512 | "${rbtohex}/bin/rbtohex")"
    RESPONSE=$(ykchalresp -2 -x $CHALLENGE 2>/dev/null)
    KEY_LENGTH=512
    ITERATIONS=1000000
    LUKS_KEY="$(echo -n $USER_PASSPHRASE | ${pbkdf2Sha512}/bin/pbkdf2-sha512 $(($KEY_LENGTH / 8)) $ITERATIONS $RESPONSE | ${rbtohex}/bin/rbtohex)"
    echo -n "$LUKS_KEY" | "${hextorb}/bin/hextorb" | cryptsetup open "/dev/disk/by-label/NIXOS" nixos-crypt --key-file=-

    # Mount the subvolumes
    mount --mkdir -o subvol="@" "/dev/mapper/nixos-crypt" "/mnt/nixos"
    mount --mkdir -o subvol="@home" "/dev/mapper/nixos-crypt" "/mnt/nixos/home"
    mount --mkdir -o subvol="@tmp" "/dev/mapper/nixos-crypt" "/mnt/nixos/tmp"
    mount --mkdir -o subvol="@var" "/dev/mapper/nixos-crypt" "/mnt/nixos/var"
  '';
in {
  nix.settings.experimental-features = ["nix-command" "flakes"];

  services = {
    openssh = {
      enable = true;
      ports = [22];
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
      };
    };
  };

  networking = {
    useDHCP = lib.mkDefault true;
    wireless.enable = false; # disable wpa_supplicant
    networkmanager.enable = true;
  };

  hardware = {
    gpgSmartcards.enable = true;
  };

  users.users = {
    nixos = {
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBFPX5biiGhDszrPE8BWvgKz4Ow1etck3E9aacuKXObQ cody@everest"
      ];
    };
  };

  systemd.services.sshd.wantedBy = pkgs.lib.mkForce ["multi-user.target"];

  system.activationScripts = {
    base-dirs = {
      text = ''
        mkdir -p /nix/var/nix/profiles/per-user/user
      '';
      deps = [];
    };
  };

  # Should make build go faster
  isoImage.squashfsCompression = "gzip -Xcompression-level 1";

  environment.systemPackages = with pkgs; [
    neofetch
    neovim
    tmux
    home-manager
    # For setting up Yubikey based FDE
    gcc
    yubikey-personalization
    openssl
    rbtohex
    hextorb
    pbkdf2Sha512
    mountykepart
  ];
}
