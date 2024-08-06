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
    alduin = pkgs.callPackage ./install/alduin {};
  };
  rebuild = {
    skyrim = {
      nixos = pkgs.callPackage ./rebuild/skyrim/nixos {};
      home = pkgs.callPackage ./rebuild/skyrim/home {};
    };
  };
  deploy = {
    alduin = {
      vm = pkgs.callPackage ./deploy/alduin/vm {};
      digital-ocean = pkgs.callPackage ./deploy/alduin/vm {};
    };
  };
  image = {
    do = {
      alduin = pkgs.callPackage ./image/digital-ocean/alduin {};
    };
  };
}
