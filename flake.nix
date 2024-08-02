{
  description = "https://github.com/Kodlak15 NixOS Configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.05";

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

    nur.url = "github:nix-community/NUR";

    nixvim = {
      url = "github:nix-community/nixvim";
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

    swwwmgr.url = "github:Kodlak15/swww-manager";
    nvim.url = "github:Kodlak15/nvim-flake";
    tweather.url = "github:Kodlak15/tweather";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-stable,
    home-manager,
    flake-utils,
    nur,
    ...
  } @ inputs: let
    inherit (self) outputs;
    lib = nixpkgs.lib // home-manager.lib;
    supportedSystems = ["x86_64-linux"];
    forEachSystem = f: lib.genAttrs supportedSystems (system: f pkgsFor.${system});
    pkgsFor = lib.genAttrs supportedSystems (system:
      import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      });
    pkgsForStable = lib.genAttrs supportedSystems (system:
      import nixpkgs-stable {
        inherit system;
        config.allowUnfree = true;
      });
  in {
    inherit lib;
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;
    packages = forEachSystem (pkgs: import ./pkgs {inherit pkgs;});
    devShells = forEachSystem (pkgs: import ./shells {inherit pkgs;});
    formatter = forEachSystem (pkgs: pkgs.alejandra);
    overlays = import ./overlays {inherit inputs;};

    nixosConfigurations = {
      "personal/everest" = lib.nixosSystem {
        modules = [./hosts/personal/everest.nix];
        specialArgs = {inherit inputs outputs;};
      };
      "personal/denali" = lib.nixosSystem {
        modules = [./hosts/personal/denali.nix];
        specialArgs = {inherit inputs outputs;};
      };
      "test/test-vm" = lib.nixosSystem {
        modules = [./hosts/test/test-vm];
        specialArgs = {inherit inputs outputs;};
      };
      "vm/korriban" = lib.nixosSystem {
        modules = [
          ./hosts/vm/korriban
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.sion = import ./home/sion/korriban.nix;
          }
        ];
        specialArgs = {inherit inputs outputs;};
      };
      "alduin/vm" = lib.nixosSystem {
        modules = [./hosts/alduin/vm];
        specialArgs = {inherit inputs outputs;};
      };
      "alduin/digital-ocean" = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          "${nixpkgs}/nixos/modules/virtualisation/digital-ocean-image.nix"
          ./hosts/alduin/digital-ocean
        ];
        specialArgs = {inherit inputs outputs;};
      };
      # alduin = {
      #   vm = lib.nixosSyster {
      #     modules = [./hosts/alduin/vm];
      #     specialArgs = {inherit inputs outputs;};
      #   };
      #   digital-ocean = lib.nixosSystem {
      #     system = "x86_64-linux";
      #     modules = [
      #       "${nixpkgs}/nixos/modules/virtualisation/digital-ocean-image.nix"
      #       ./hosts/alduin/digital-ocean
      #     ];
      #     specialArgs = {inherit inputs outputs;};
      #   };
      # };
      iso = {
        minimal = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
            ./hosts/iso/minimal
          ];
          specialArgs = {inherit inputs outputs;};
        };
      };
    };

    homeConfigurations = {
      "cody@personal/everest" = lib.homeManagerConfiguration {
        modules = [
          ./home/cody/everest.nix
          nur.hmModules.nur # Nix User Repository
        ];
        pkgs = pkgsFor.x86_64-linux;
        extraSpecialArgs = {
          pkgs-stable = pkgsForStable.x86_64-linux;
          inherit inputs outputs;
        };
      };
      "cody@personal/denali" = lib.homeManagerConfiguration {
        modules = [
          ./home/cody/denali.nix
          nur.hmModules.nur # Nix User Repository
        ];
        pkgs = pkgsFor.x86_64-linux;
        extraSpecialArgs = {
          pkgs-stable = pkgsForStable.x86_64-linux;
          inherit inputs outputs;
        };
      };
      "user@test/test-vm" = lib.homeManagerConfiguration {
        modules = [
          ./home/user/testvm.nix
        ];
        pkgs = pkgsFor.x86_64-linux;
        extraSpecialArgs = {
          pkgs-stable = pkgsForStable.x86_64-linux;
          inherit inputs outputs;
        };
      };
    };
  };
}
