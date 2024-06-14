everest:
	sudo ./scripts/rebuild.py --flake personal/everest --option system --user cody

denali:
	sudo ./scripts/rebuild.py --flake personal/denali --option system --user cody

everest-home:
	./scripts/rebuild.py --flake personal/everest --option home --user cody

denali-home:
	./scripts/rebuild.py --flake personal/denali --option home --user cody

everest-full:
	sudo ./scripts/rebuild.py --flake personal/everest --option system --user cody 
	./scripts/rebuild.py --flake personal/everest --option home --user cody

denali-full:
	sudo ./scripts/rebuild.py --flake personal/denali --option system --user cody 
	./scripts/rebuild.py --flake personal/denali --option home --user cody

update:
	nix flake update

gc:
	nix-collect-garbage
