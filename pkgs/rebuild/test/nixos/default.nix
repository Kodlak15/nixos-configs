{pkgs, ...}:
pkgs.writeShellScriptBin "rebuild" ''
  sudo nixos-rebuild switch --flake ".#test/$(hostname)" --max-jobs auto
''
