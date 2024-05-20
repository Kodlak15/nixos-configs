{pkgs, ...}: {
  home.packages = with pkgs; [
    lutris
    protontricks
    gamescope
  ];
}
