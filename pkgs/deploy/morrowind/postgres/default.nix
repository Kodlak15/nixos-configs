{pkgs, ...}:
pkgs.writeShellScriptBin "deploy" ''
  nixos-rebuild switch --flake .#digital-ocean/morrowind/postgres --target-host morrowind-laptop-vm --build-host cody@localhost --max-jobs auto
''
