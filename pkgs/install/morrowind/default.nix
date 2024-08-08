{pkgs, ...}:
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

  BOOTDISK="/dev/sda"
  ROOTDISK="/dev/sda"
  NBOOT="1"
  NROOT="2"

  if [[ "$ROOTDISK" == "$BOOTDISK" && "$NROOT" == "$NBOOT" ]]; then
    echo "Error: attempting to use the same partition for LUKS and BOOT, exiting..."
    exit 1
  fi

  if [[ -n "$(echo "$ROOTDISK" | grep "nvme")" ]]; then
    ENDLUKS="p$NROOT"
  else
    ENDLUKS="$NROOT"
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
  NIXCFG="morrowind/vm"

  # Wipe and format the Root disk
  sgdisk -o "$ROOTDISK"
  sgdisk -g "$ROOTDISK"

  # Create the partitions
  sgdisk -n "$NBOOT"::+"$BOOTSIZE"M --typecode="$NBOOT":ef00 "$BOOTDISK"
  sgdisk -n "$NROOT"::-0 --typecode="$NROOT":8300 "$ROOTDISK"
  partprobe "$ROOTDISK"

  # Create the boot filesystem
  mkfs.fat -F 32 -n "EFI-NIXOS" "$BOOTPART"

  # Create the root filesytem
  # mkfs.btrfs -L "ROOT" "$ROOTPART" -f
  mkfs.ext4 -L "ROOT" "$ROOTPART"

  # Create subvolumes
  # mount --mkdir "$ROOTPART" "$MOUNTPOINT"
  # btrfs subvolume create "$MOUNTPOINT/@"
  # btrfs subvolume create "$MOUNTPOINT/@home"
  # btrfs subvolume create "$MOUNTPOINT/@tmp"
  # btrfs subvolume create "$MOUNTPOINT/@var"
  # umount "$MOUNTPOINT"

  # Mount the subvolumes
  # mount -o subvol="@" "$ROOTPART" "$MOUNTPOINT"
  # mount --mkdir -o subvol="@home" "$ROOTPART" "$MOUNTPOINT/home"
  # mount --mkdir -o subvol="@tmp" "$ROOTPART" "$MOUNTPOINT/tmp"
  # mount --mkdir -o subvol="@var" "$ROOTPART" "$MOUNTPOINT/var"
  mount --mkdir "$ROOTPART" "$MOUNTPOINT"

  # Mount the boot partition
  mount -o umask=0077 --mkdir "$BOOTPART" "$MOUNTPOINT/boot"

  # Generate the initial configuration
  nixos-generate-config --root "$MOUNTPOINT" --no-filesystems

  # Install the system (skip setting initial password)
  nixos-install --root "$MOUNTPOINT" --flake "$FLAKE#$NIXCFG"

  # Unmount all volumes
  umount -R "$MOUNTPOINT"

  echo "NixOS was installed successfully!"
''
