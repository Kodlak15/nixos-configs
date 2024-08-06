{pkgs, ...}:
pkgs.writeShellScriptBin "rebuild" ''
  host_type="$(hostnamectl chassis | xargs)"
  home-manager switch --flake ".#$(whoami)@skyrim/$host_type" --max-jobs auto
''
