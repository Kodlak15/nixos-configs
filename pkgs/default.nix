{pkgs ? import <nixpkgs> {}, ...}: {
  openweathercli = pkgs.callPackage ./openweathercli {};
  swww-manager = pkgs.python3Packages.callPackage ./swww-manager {};
  go-blueprint = pkgs.callPackage ./go-blueprint {};
  # minimal-iso = pkgs.callPackage ./minimal-iso {inherit self;};
  install = {
    personal = {
      everest = pkgs.callPackage ./install/personal/everest {};
      denali = pkgs.callPackage ./install/personal/denali {};
    };
    test = {
      test-vm = pkgs.callPackage ./install/test/test-vm {};
    };
  };
  install = {
    personal = {
      nixos = pkgs.callPackage ./rebuild/personal/nixos {};
      home = pkgs.callPackage ./rebuild/personal/home {};
    };
    test = {
      nixos = pkgs.callPackage ./rebuild/test/nixos {};
      home = pkgs.callPackage ./rebuild/test/home {};
    };
  };
}
