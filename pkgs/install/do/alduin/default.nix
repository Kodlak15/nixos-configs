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

    BOOTDISK="/dev/vda"
    ROOTDISK="/dev/vda"
    NBOOT="1"
    NROOT="2"

    if [[ "$ROOTDISK" == "$BOOTDISK" && "$NLUKS" == "$NBOOT" ]]; then
      echo "Error: attempting to use the same partition for LUKS and BOOT, exiting..."
      exit 1
    fi

    if [[ -n "$(echo "$ROOTDISK" | grep "nvme")" ]]; then
      ENDLUKS="p$NLUKS"
    else
      ENDLUKS="$NLUKS"
    fi

    if [[ -n "$(echo "$BOOTDISK" | grep "nvme")" ]]; then
      ENDBOOT="p$NBOOT"
    else
      ENDBOOT="$NBOOT"
    fi

    ROOTPART="$ROOTDISK$ENDLUKS"
    BOOTPART="$BOOTDISK$ENDBOOT"

    # The size of the boot partition (mb)
    BOOTSIZE=512

    # Mountpoint used during installation
    MOUNTPOINT="/mnt/nixos"

    # The NixOS configuration to use
    NIXCFG="do/alduin"

    # Wipe and format the LUKS disk
    echo "$ROOTDISK will now be formatted and all data will be wiped!"
    read -p "Continue? (y/n): " CONFIRM
    if [[ "$CONFIRM" != "y" ]]; then
      echo "Exiting..."
      exit 0
    else
      sgdisk -o "$ROOTDISK" &>/dev/null
      sgdisk -g "$ROOTDISK" &>/dev/null
    fi

    # Create the partitions
    sgdisk -n "$NBOOT"::+"$BOOTSIZE"M --typecode=1:ef00 "$ROOTDISK" &>/dev/null
    sgdisk -n "$NLUKS"::-0 --typecode=2:8300 "$ROOTDISK" &>/dev/null
    partprobe "$ROOTDISK" &>/dev/null

    # Create the boot filesystem
    mkfs.fat -F 32 -n "EFI-NIXOS" "$BOOTPART" &>/dev/null

    # Create the root filesytem
    mkfs.btrfs -L "ROOT" "$ROOTPART" -f &>/dev/null

    # Create subvolumes
    mount --mkdir "$ROOTPART" "$MOUNTPOINT"
    btrfs subvolume create "$MOUNTPOINT/@" &>/dev/null
    btrfs subvolume create "$MOUNTPOINT/@home" &>/dev/null
    btrfs subvolume create "$MOUNTPOINT/@tmp" &>/dev/null
    btrfs subvolume create "$MOUNTPOINT/@var" &>/dev/null
    umount "$MOUNTPOINT"

    # Mount the subvolumes
    mount -o subvol="@" "$ROOTPART" "$MOUNTPOINT"
    mount --mkdir -o subvol="@home" "$ROOTPART" "$MOUNTPOINT/home"
    mount --mkdir -o subvol="@tmp" "$ROOTPART" "$MOUNTPOINT/tmp"
    mount --mkdir -o subvol="@var" "$ROOTPART" "$MOUNTPOINT/var"

    # Mount the boot partition
    mount -o umask=0077 --mkdir "$BOOTPART" "$MOUNTPOINT/boot"

    # Generate the initial configuration
    nixos-generate-config --root "$MOUNTPOINT" --no-filesystems &>/dev/null

    # Install the system (skip setting initial password)
    nixos-install --root "$MOUNTPOINT" --flake "$FLAKE#$NIXCFG" --no-root-password &>/dev/null

    # Unmount all volumes
    umount -R "$MOUNTPOINT"

    echo "NixOS was installed successfully!"
  ''
