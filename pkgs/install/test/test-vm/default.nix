{pkgs, ...}: let
  helpers = import ../../helpers.nix {inherit pkgs;};
  inherit (helpers) rbtohex hextorb pbkdf2Sha512;
in
  pkgs.writeShellScriptBin "install.sh" ''
    set -e

    # Make sure user running the script is root
    if [[ ! "$EUID" -eq 0 ]]; then
    	echo "This must be run as root!"
    	echo "Run 'sudo -i' to switch to the root user."
    	exit 1
    fi

    # The flake to use
    FLAKE="github:Kodlak15/nixos-flake"

    # Select disks to use
    lsblk
    read -p "Choose the disk to use for LUKS: " LUKSDISK
    read -p "Choose the disk to use for BOOT: " BOOTDISK
    LUKSDISK="/dev/$LUKSDISK"
    BOOTDISK="/dev/$BOOTDISK"

    if [[ "$LUKSDISK" == "$BOOTDISK" ]]; then
      if [[ -n "$(echo "$LUKSDISK" | grep "nvme")" ]]; then
        ENDBOOT="p1"
        ENDLUKS="p2"
      else
        ENDBOOT="1"
        ENDLUKS="2"
      fi
    else
      if [[ -n "$(echo "$BOOTDISK" | grep "nvme")" ]]; then
        ENDBOOT="p1"
      else
        ENDBOOT="1"
      fi
      if [[ -n "$(echo "$LUKSDISK" | grep "nvme")" ]]; then
        ENDLUKS="p1"
      else
        ENDLUKS="1"
      fi
    fi

    LUKSPART="$LUKSDISK$ENDLUKS"
    BOOTPART="$BOOTDISK$ENDBOOT"

    # The size of the boot partition (mb)
    BOOTSIZE=512

    # Mountpoint used during installation
    MOUNTPOINT="/mnt/nixos"

    # The NixOS configuration to use
    NIXCFG="test/test-vm"

    # Slot to be used on the yubikey (set to 0 to skip programming)
    SLOT="2"

    # Program the yubikey
    if [[ ! "$SLOT" == "0" ]]; then
    	ykpersonalize -"$SLOT" -y -ochal-resp -ochal-hmac &>/dev/null
    fi

    # Create the partitions
    sgdisk -g "$LUKSDISK" &>/dev/null
    sgdisk -n 1::+"$BOOTSIZE"M --typecode=1:ef00 "$LUKSDISK" &>/dev/null
    sgdisk -n 2::-0 --typecode=2:8300 "$LUKSDISK" &>/dev/null
    partprobe "$LUKSDISK" &>/dev/null

    # Read 2FA password
    echo "Enter 2FA password:"
    read -s USER_PASSPHRASE

    # Calculate the initial salt (length can be any integer in range 16-64)
    SALT_LENGTH=16
    SALT="$(dd if=/dev/random bs=1 count=$SALT_LENGTH 2>/dev/null | "${rbtohex}/bin/rbtohex")"

    # Calculate the initial challenge and response
    CHALLENGE="$(echo -n $SALT | openssl dgst -binary -sha512 | "${rbtohex}/bin/rbtohex")"
    RESPONSE=$(ykchalresp -2 -x $CHALLENGE 2>/dev/null)

    # Calculate the LUKS slot key
    KEY_LENGTH=512
    ITERATIONS=1000000
    LUKS_KEY="$(echo -n $USER_PASSPHRASE | ${pbkdf2Sha512}/bin/pbkdf2-sha512 $(($KEY_LENGTH / 8)) $ITERATIONS $RESPONSE | ${rbtohex}/bin/rbtohex)"

    # Create the LUKS device
    CIPHER=aes-xts-plain64
    HASH=sha512
    echo -n "$LUKS_KEY" | "${hextorb}/bin/hextorb" | cryptsetup luksFormat --label "NIXOS" --cipher="$CIPHER" --key-size="$KEY_LENGTH" --hash="$HASH" --key-file=- "$LUKSPART" &>/dev/null

    # Create the boot filesystem
    mkfs.fat -F 32 -n "EFI-NIXOS" "$BOOTPART" &>/dev/null

    # Store the salt and iterations on the boot volume
    mount --mkdir "$BOOTPART" /boot
    mkdir -p /boot/crypt-storage
    echo -ne "$SALT\n$ITERATIONS" > /boot/crypt-storage/default
    umount /boot

    # Open the LUKS device
    echo -n "$LUKS_KEY" | "${hextorb}/bin/hextorb" | cryptsetup open "$LUKSPART" nixos-crypt --key-file=-

    # The encrypted root partition of the new system
    ROOT="/dev/mapper/nixos-crypt"

    # Create the root filesytem
    mkfs.btrfs -L "ROOT" "$ROOT" -f &>/dev/null

    # Create subvolumes
    mount --mkdir "$ROOT" "$MOUNTPOINT"
    btrfs subvolume create "$MOUNTPOINT/@" &>/dev/null
    btrfs subvolume create "$MOUNTPOINT/@home" &>/dev/null
    btrfs subvolume create "$MOUNTPOINT/@tmp" &>/dev/null
    btrfs subvolume create "$MOUNTPOINT/@var" &>/dev/null
    umount "$MOUNTPOINT"

    # Mount the subvolumes
    mount -o subvol="@" "$ROOT" "$MOUNTPOINT"
    mount --mkdir -o subvol="@home" "$ROOT" "$MOUNTPOINT/home"
    mount --mkdir -o subvol="@tmp" "$ROOT" "$MOUNTPOINT/tmp"
    mount --mkdir -o subvol="@var" "$ROOT" "$MOUNTPOINT/var"

    # Mount the boot partition
    mount -o umask=0077 --mkdir "$BOOTPART" "$MOUNTPOINT/boot"

    # Generate the initial configuration
    nixos-generate-config --root "$MOUNTPOINT" --no-filesystems &>/dev/null

    # Install the system (skip setting initial password)
    nixos-install --root "$MOUNTPOINT" --flake "$FLAKE#$NIXCFG" &>/dev/null

    # Unmount all volumes
    umount -R "$MOUNTPOINT"

    # Close the LUKS partition
    cryptsetup luksClose "nixos-crypt"

    echo "NixOS was installed successfully!"
  ''
