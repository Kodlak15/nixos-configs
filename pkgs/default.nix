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
    alduin = pkgs.callPackage ./install/do/alduin {};
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
    do = {
      alduin = pkgs.callPackage ./deploy/alduin {};
    };
  };
  image = {
    do = {
      alduin = pkgs.callPackage ./image/digital-ocean/alduin {};
    };
  };
}
