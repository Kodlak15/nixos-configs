{pkgs, ...}:
pkgs.writeShellScriptBin "rebuild" ''
  home-manager switch --flake ".#$(whoami)@test/$(hostname)" --max-jobs auto
''
