{pkgs ? import <nixpkgs> {}, ...}: {
  openweathercli = pkgs.callPackage ./openweathercli {};
  swww-manager = pkgs.python3Packages.callPackage ./swww-manager {};
  go-blueprint = pkgs.callPackage ./go-blueprint {};
  minimal-iso = pkgs.callPackage ./minimal-iso {};
  install = {
    personal = {
      everest = pkgs.callPackage ./install/personal/everest {};
      denali = pkgs.callPackage ./install/personal/denali {};
    };
    test = {
      test-vm = pkgs.callPackage ./install/test/test-vm {};
    };
    vm = {
      korriban = pkgs.callPackage ./install/vm/korriban {};
    };
    alduin = pkgs.callPackage ./install/alduin {};
  };
  rebuild = {
    personal = {
      nixos = pkgs.callPackage ./rebuild/personal/nixos {};
      home = pkgs.callPackage ./rebuild/personal/home {};
    };
  };
  deploy = {
    vm = {
      korriban = pkgs.callPackage ./deploy/korriban {};
    };
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
