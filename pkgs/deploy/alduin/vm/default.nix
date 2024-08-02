{pkgs, ...}:
pkgs.writeShellScriptBin "deploy" ''
  nixos-rebuild switch --flake .#alduin/vm --target-host alduin-laptop-vm --build-host cody@localhost --max-jobs auto
''
