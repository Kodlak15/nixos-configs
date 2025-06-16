{pkgs, ...}: {
  # TODO: make a home manager module to customize with nix
  home.packages = with pkgs; [opencode];
}
