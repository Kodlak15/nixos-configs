{
  description = "My nixos configurations.";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland-plugins.url = "github:hyprwm/hyprland-plugins";
    hyprcursor.url = "github:hyprwm/hyprcursor";
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    eww = {
      url = "github:elkowar/eww";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.rust-overlay.follows = "rust-overlay";
    };
    eww-configs.url = "github:Kodlak15/eww-configs";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ghostty.url = "github:ghostty-org/ghostty";
    impermanence.url = "github:nix-community/impermanence";
    swwwmgr.url = "github:Kodlak15/swww-manager";
    nvim.url = "github:Kodlak15/nvim-flake";
    tweather.url = "github:Kodlak15/tweather";
  };

  outputs = inputs @ {
    self,
    flake-parts,
    ...
  }: let
    inherit (self) outputs;
  in
    flake-parts.lib.mkFlake {inherit inputs;} {
      debug = false; # If having issues, set to true for useful debugging output in the repl
      systems = ["x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin"];
      perSystem = {
        config,
        self',
        inputs',
        pkgs,
        system,
        ...
      }: {
        # Packages, shells, etc.
      };
      flake = {
        nixosConfigurations = {
          "skyrim" = inputs.nixpkgs.lib.nixosSystem rec {
            system = "x86_64-linux";
            modules = [
              ./hosts/skyrim
              inputs.disko.nixosModules.disko
              inputs.impermanence.nixosModules.impermanence
              inputs.sops-nix.nixosModules.sops
            ];
            specialArgs = {
              inherit inputs outputs;
            };
          };
          "cyrodil" = inputs.nixpkgs.lib.nixosSystem rec {
            system = "x86_64-linux";
            modules = [
              ./hosts/cyrodil
              inputs.disko.nixosModules.disko
              inputs.impermanence.nixosModules.impermanence
              inputs.sops-nix.nixosModules.sops
            ];
            specialArgs = {
              inherit inputs outputs;
            };
          };
          "valenwood" = inputs.nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
              ./hosts/valenwood
              inputs.disko.nixosModules.disko
              inputs.impermanence.nixosModules.impermanence
              inputs.sops-nix.nixosModules.sops
              inputs.home-manager.nixosModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  users.cody = import ./home/cody/valenwood;
                  backupFileExtension = "backup";
                  extraSpecialArgs = {inherit inputs outputs;};
                };
              }
            ];
            specialArgs = {inherit inputs outputs;};
          };
        };

        homeConfigurations = {
          "cody@skyrim" = inputs.home-manager.lib.homeManagerConfiguration {
            modules = [
              ./home/cody/skyrim
            ];
            pkgs = import inputs.nixpkgs {
              system = "x86_64-linux";
              overlays = [
                inputs.nur.overlays.default
                (final: prev: {blender = prev.blender.override {cudaSupport = true;};})
              ];
              config.allowUnfree = true;
            };
            extraSpecialArgs = {
              inherit inputs outputs;
            };
          };
          "cody@cyrodil" = inputs.home-manager.lib.homeManagerConfiguration {
            # "temp" = inputs.home-manager.lib.homeManagerConfiguration {
            modules = [
              ./home/cody/cyrodil
            ];
            pkgs = import inputs.nixpkgs {
              system = "x86_64-linux";
              overlays = [
                inputs.nur.overlays.default
                (final: prev: {
                  blender = prev.blender.override {cudaSupport = true;};
                })
              ];
              config.allowUnfree = true;
            };
            extraSpecialArgs = {
              inherit inputs outputs;
            };
          };
        };
      };
    };
}
