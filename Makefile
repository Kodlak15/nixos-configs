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

deploy-do-alduin:
	nix run .#deploy.do.alduin

deploy-vm-alduin:
	nix run .#deploy.vm.alduin

image-alduin:
	nix build .#nixosConfigurations.alduin.digital-ocean.config.system.build.digitalOceanImage
