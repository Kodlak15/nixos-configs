{pkgs, ...}:
pkgs.writeShellScriptBin "deploy" ''
  nixos-rebuild switch --flake .#digital-ocean/morrowind/postgres --target-host morrowind-vm-pg --build-host cody@localhost --max-jobs auto
''
