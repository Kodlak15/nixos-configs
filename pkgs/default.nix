{pkgs ? import <nixpkgs> {}, ...}: {
  openweathercli = pkgs.callPackage ./openweathercli {};
  swww-manager = pkgs.python3Packages.callPackage ./swww-manager {};
  go-blueprint = pkgs.callPackage ./go-blueprint {};
  minimal-iso = pkgs.callPackage ./minimal-iso {};
  # Automatically install NixOS
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
  };
  # Rebuild personal system
  rebuild = {
    personal = {
      nixos = pkgs.callPackage ./rebuild/personal/nixos {};
      home = pkgs.callPackage ./rebuild/personal/home {};
    };
  };
  # Rebuild and deploy to remote host
  deploy = {
    vm = {
      korriban = pkgs.callPackage ./deploy/korriban {};
    };
  };
  image = {
    # digital-ocean = pkgs.callPackage ./image/digital-ocean {};
    digital-ocean = pkgs.callPackage ./image/digital-ocean {};
  };
}
