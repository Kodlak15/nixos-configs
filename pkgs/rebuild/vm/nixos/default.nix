{pkgs, ...}:
pkgs.writeShellScriptBin "rebuild" ''
  if [[ -z "$(cat /proc/mounts | grep "boot")" ]]; then
    sudo mount "/dev/disk/by-label/EFI-NIXOS" "/boot" || exit 1
  fi

  sudo nixos-rebuild switch --flake ".#vm/$(hostname)" --max-jobs auto
  sudo umount "/boot"
''
