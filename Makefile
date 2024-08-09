skyrim: 
	./scripts/rebuild.sh --all

skyrim-nixos:
	./scripts/rebuild.sh --nixos

skyrim-home:
	./scripts/rebuild.sh --home

morrowind:
	./scripts/deploy.sh morrowind --local

iso-minimal:
	nix build .#nixosConfigurations.iso.minimal.config.system.build.isoImage

update:
	nix flake update

gc:
	nix-collect-garbage
