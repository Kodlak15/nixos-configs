{pkgs, ...}:
pkgs.writeShellScriptBin "deploy" ''
  nixos-rebuild switch --flake .#vm/korriban --target-host root@korriban --build-host cody@localhost --max-jobs auto
''
