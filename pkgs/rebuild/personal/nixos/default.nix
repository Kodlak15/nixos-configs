{pkgs, ...}:
pkgs.writeShellScriptBin "rebuild" ''
  sudo nixos-rebuild switch --flake ".#personal/$(hostname)" --max-jobs auto
''
