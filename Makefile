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

iso-minimal:
	nix build .#nixosConfigurations.iso.minimal.config.system.build.isoImage

update:
	nix flake update

gc:
	nix-collect-garbage

deploy-korriban:
	nix run .#deploy.vm.korriban

deploy-alduin:
	nix run .#deploy.do.alduin

image-alduin:
	nix build .#nixosConfigurations.image.do.alduin.config.system.build.digitalOceanImage
