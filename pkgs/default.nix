{pkgs ? import <nixpkgs> {}, ...}: {
  openweathercli = pkgs.callPackage ./openweathercli {};
  swww-manager = pkgs.python3Packages.callPackage ./swww-manager {};
  go-blueprint = pkgs.callPackage ./go-blueprint {};
  minimal-iso = pkgs.callPackage ./minimal-iso {};
  cursor = pkgs.callPackage ./cursor {};
  install = {
    skyrim = {
      desktop = pkgs.callPackage ./install/skyrim/desktop {};
      laptop = pkgs.callPackage ./install/skyrim/laptop {};
    };
    morrowind = pkgs.callPackage ./install/morrowind {};
  };
}
