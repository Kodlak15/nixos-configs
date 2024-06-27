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
            zellij
            nodejs
            nodePackages.typescript
          ];

          shellHook = ''
            exec $SHELL -c zellij
          '';
        };
      };
    });
}
