{pkgs, ...}:
pkgs.writeShellScriptBin "testpkg" ''
  ${pkgs.cowsay}/bin/cowsay "your testpkg was successfully called!"!
''
