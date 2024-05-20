{pkgs, ...}: {
  # TODO how can I include config.yaml without revealing secrets in version control?
  home.packages = [(pkgs.openweathercli)];
}
