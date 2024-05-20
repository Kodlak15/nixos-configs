{
  description = "https://github.com/Kodlak15 NixOS Configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.11";

    flake-utils = {
      url = "github:numtide/flake-utils";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      # url = "github:hyprwm/Hyprland";
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1"; # TODO temporary
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
    };

    nur = {
      url = "github:nix-community/NUR";
    };

    rose-pine-hyprcursor = {
      url = "github:ndom91/rose-pine-hyprcursor";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    eww = {
      url = "github:elkowar/eww";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.rust-overlay.follows = "rust-overlay";
    };

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    templ = {
      url = "github:a-h/templ";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    swwwmgr = {
      url = "github:Kodlak15/swww-manager";
    };

    nvim = {
      url = "github:Kodlak15/nvim-flake";
    };
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
    shells = forEachSystem (pkgs: import ./shells {});
    formatter = forEachSystem (pkgs: pkgs.alejandra);
    overlays = import ./overlays {inherit inputs;};

    nixosConfigurations = {
      # Desktop
      "personal/everest" = lib.nixosSystem {
        modules = [./hosts/everest.nix];
        specialArgs = {inherit inputs outputs;};
      };
      # Laptop
      "personal/denali" = lib.nixosSystem {
        modules = [./hosts/denali.nix];
        specialArgs = {inherit inputs outputs;};
      };
      # Security VM (desktop)
      "security/poltergeist" = lib.nixosSystem {
        modules = [./hosts/poltergeist.nix];
        specialArgs = {inherit inputs outputs;};
      };
      # Security VM (laptop)
      "security/casper" = lib.nixosSystem {
        modules = [./hosts/casper.nix];
        specialArgs = {inherit inputs outputs;};
      };
    };

    homeConfigurations = {
      # Desktop
      "cody@personal/everest" = lib.homeManagerConfiguration {
        # modules = [./home/cody/everest.nix];
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
      # Laptop
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
      # Security VM (desktop)
      "anon@security/poltergeist" = lib.homeManagerConfiguration {
        modules = [./home/anon/poltergeist.nix];
        pkgs = pkgsFor.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
      };
      # Security VM (laptop)
      "anon@security/casper" = lib.homeManagerConfiguration {
        modules = [./home/anon/casper.nix];
        pkgs = pkgsFor.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
      };
    };
  };
}
