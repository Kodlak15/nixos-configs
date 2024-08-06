skyrim: 
	nix run .#rebuild.skyrim.nixos && nix run .#rebuild.skyrim.home

skyrim-nixos:
	nix run .#rebuild.skyrim.nixos

skyrim-home:
	nix run .#rebuild.skyrim.home

morrowind-deploy-do:
	nix run .#deploy.morrowind.digital-ocean

morrowind-deploy-pg:
	nix run .#deploy.morrowind.postgres

morrowind-deploy-vm:
	nix run .#deploy.morrowind.vm

morrowind-image-do:
	nix build .#nixosConfigurations.morrowind.digital-ocean.config.system.build.digitalOceanImage

morrowind-image-pg:
	nix build .#nixosConfigurations.morrowind.digital-ocean.config.system.build.digitalOceanImage

iso-minimal:
	nix build .#nixosConfigurations.iso.minimal.config.system.build.isoImage

update:
	nix flake update

gc:
	nix-collect-garbage
