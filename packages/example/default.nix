{pkgs, ...}:
pkgs.writeShellScriptBin "example" ''
  ${pkgs.cowsay}/bin/cowsay "here is that example you asked for"!
''
