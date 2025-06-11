{pkgs, ...}: {
  # TODO: make a home manager module to customize later
  # project is still early in development, so just testing for now
  home.packages = [pkgs.opencode];
}
