personal: 
	nix run .#rebuild.personal.nixos && nix run .#rebuild.personal.home

test: 
	nix run .#rebuild.test.nixos && nix run .#rebuild.test.home

personal-nixos:
	nix run .#rebuild.personal.nixos

test-nixos:
	nix run .#rebuild.test.nixos

personal-home:
	nix run .#rebuild.personal.home

test-home:
	nix run .#rebuild.test.home

update:
	nix flake update

gc:
	nix-collect-garbage
