{pkgs, ...}:
pkgs.writeShellScriptBin "deploy" ''
  nixos-rebuild switch --flake .#morrowind/vm --target-host morrowind-laptop-vm --build-host cody@localhost --max-jobs auto
''
