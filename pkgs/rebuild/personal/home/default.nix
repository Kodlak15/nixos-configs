{pkgs, ...}:
pkgs.writeShellScriptBin "rebuild" ''
  home-manager switch --flake ".#$(whoami)@personal/$(hostname)" --max-jobs auto
''
