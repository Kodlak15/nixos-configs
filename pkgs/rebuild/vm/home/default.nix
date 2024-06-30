{pkgs, ...}:
pkgs.writeShellScriptBin "rebuild" ''
  home-manager switch --flake ".#$(whoami)@vm/$(hostname)" --max-jobs auto
''
