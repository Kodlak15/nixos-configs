skyrim: 
	./scripts/rebuild.sh --all

skyrim-nixos:
	./scripts/rebuild.sh --nixos

skyrim-home:
	./scripts/rebuild.sh --home

morrowind:
	./scripts/deploy.sh morrowind --local

rift:
	./scripts/deploy.sh rift --local

elsweyr:
	./scripts/deploy.sh elsweyr --local

iso-minimal:
	nix build .#nixosConfigurations.minimal-iso.config.system.build.isoImage

digital-ocean-image:
	nix build .#nixosConfigurations.digital-ocean-image.config.system.build.digitalOceanImage

update:
	nix flake update

sops-update:
	./scripts/sops.sh --update

gc:
	nix-collect-garbage
