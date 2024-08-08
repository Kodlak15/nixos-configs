{pkgs, ...}:
pkgs.writeShellScriptBin "deploy" ''
  nixos-rebuild switch --flake .#morrowind --target-host morrowind --build-host cody@localhost --max-jobs auto
''
