{pkgs, ...}:
pkgs.writeShellScriptBin "rebuild" ''
  if [[ -z "$(cat /proc/mounts | grep "boot")" ]]; then
    sudo mount "/dev/disk/by-label/EFI-NIXOS" "/boot" || exit 1
  fi

  host_type="$(hostnamectl chassis | xargs)"
  sudo nixos-rebuild switch --flake ".#skyrim/$host_type" --max-jobs auto
  sudo umount "/boot"
''
