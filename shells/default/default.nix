{pkgs, ...}:
pkgs.mkShell {
  # find way to use my custom packages in this shell
  packages = [pkgs.testpkg];

  shellHook = ''
    exec zsh -c zellij
  '';
}
