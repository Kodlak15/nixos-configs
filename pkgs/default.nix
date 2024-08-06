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
  };
  rebuild = {
    skyrim = {
      nixos = pkgs.callPackage ./rebuild/skyrim/nixos {};
      home = pkgs.callPackage ./rebuild/skyrim/home {};
    };
  };
  deploy = {
    morrowind = {
      vm = pkgs.callPackage ./deploy/morrowind/vm {};
      digital-ocean = pkgs.callPackage ./deploy/morrowind/vm {};
    };
  };
  image = {
    do = {
      morrowind = pkgs.callPackage ./image/digital-ocean/morrowind {};
    };
  };
}
