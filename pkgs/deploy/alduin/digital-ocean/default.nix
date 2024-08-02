{pkgs, ...}:
pkgs.writeShellScriptBin "deploy" ''
  nixos-rebuild switch --flake .#do/alduin --target-host alduin --build-host cody@localhost --max-jobs auto
''
