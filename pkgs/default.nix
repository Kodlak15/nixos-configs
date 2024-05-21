{pkgs ? import <nixpkgs> {}}: {
  openweathercli = pkgs.callPackage ./openweathercli {};
  swww-manager = pkgs.python3Packages.callPackage ./swww-manager {};
  dark-space = pkgs.callPackage ./dark-space {};
}
