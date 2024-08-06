skyrim: 
	nix run .#rebuild.skyrim.nixos && nix run .#rebuild.skyrim.home

skyrim-nixos:
	nix run .#rebuild.skyrim.nixos

skyrim-home:
	nix run .#rebuild.skyrim.home

alduin-deploy-do:
	nix run .#deploy.alduin.digital-ocean

alduin-deploy-vm:
	nix run .#deploy.alduin.vm

alduin-image-do:
	nix build .#nixosConfigurations.alduin.digital-ocean.config.system.build.digitalOceanImage

iso-minimal:
	nix build .#nixosConfigurations.iso.minimal.config.system.build.isoImage

update:
	nix flake update

gc:
	nix-collect-garbage
