{pkgs ? import <nixpkgs> {}, ...}: {
  openweathercli = pkgs.callPackage ./openweathercli {};
  swww-manager = pkgs.python3Packages.callPackage ./swww-manager {};
  go-blueprint = pkgs.callPackage ./go-blueprint {};
  minimal-iso = pkgs.callPackage ./minimal-iso {};
  install = {
    skyrim = {
      desktop = pkgs.callPackage ./install/skyrim/desktop {};
      laptop = pkgs.callPackage ./install/skyrim/laptop {};
    };
    test = {
      test-vm = pkgs.callPackage ./install/test/test-vm {};
    };
    morrowind = pkgs.callPackage ./install/morrowind {};
    morrowind-pg = pkgs.callPackage ./install/morrowind/postgres {};
  };
  deploy = {
    morrowind = pkgs.callPackage ./deploy/morrowind {};
  };
  image = {
    do = {
      morrowind = pkgs.callPackage ./image/digital-ocean/morrowind {};
    };
  };
}
