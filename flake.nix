{
  description = "Svelte development environment for Cascade Botanicals web app";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {inherit system;};
    in {
      devShells = {
        default = pkgs.mkShell {
          packages = with pkgs; [
            # Dev environment
            zellij
            # JS
            nodejs
            nodePackages.typescript
            # Database
            postgresql_16
            goose
          ];

          # Environment variables
          GOOSE_MIGRATION_DIR = "./migrations/";
          GOOSE_DBSTRING = "host=0.0.0.0 dbname=postgres user=postgres password=example sslmode=disable";
          GOOSE_DRIVER = "postgres";

          shellHook = ''
            exec $SHELL -c zellij
          '';
        };
        testLocal = pkgs.mkShell {
          packages = with pkgs; [
            # Dev environment
            zellij
            # JS
            nodejs
            nodePackages.typescript
            # Database
            postgresql_16
            goose
          ];

          # Environment variables
          GOOSE_MIGRATION_DIR = "./migrations/";
          GOOSE_DBSTRING = "host=192.168.122.142 dbname=postgres user=postgres password=example sslmode=disable";
          GOOSE_DRIVER = "postgres";

          shellHook = ''
            exec $SHELL -c zellij
          '';
        };
      };
      packages = {
        default = pkgs.callPackage ./default.nix {};
      };
    });
}
