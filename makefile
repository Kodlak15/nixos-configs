everest:
	sudo ./scripts/rebuild.py --flake personal/everest --option system --user cody

denali:
	sudo ./scripts/rebuild.py --flake personal/denali --option system --user cody

poltergeist:
	sudo ./scripts/rebuild.py --flake security/poltergeist --option system --user anon 

casper:
	sudo ./scripts/rebuild.py --flake security/casper --option system --user anon 

everest-home:
	./scripts/rebuild.py --flake personal/everest --option home --user cody

denali-home:
	./scripts/rebuild.py --flake personal/denali --option home --user cody

poltergeist-home:
	./scripts/rebuild.py --flake security/poltergeist --option home --user anon 

casper-home:
	./scripts/rebuild.py --flake security/casper --option home --user anon 

everest-full:
	sudo ./scripts/rebuild.py --flake personal/everest --option system --user cody && ./scripts/rebuild.py --flake personal/everest --option home --user cody

denali-full:
	sudo ./scripts/rebuild.py --flake personal/denali --option system --user cody && ./scripts/rebuild.py --flake personal/denali --option home --user cody

poltergeist-full:
	sudo ./scripts/rebuild.py --flake security/poltergeist --option system --user anon && ./scripts/rebuild.py --flake security/poltergeist --option home --user anon 

casper-full:
	sudo ./scripts/rebuild.py --flake security/casper --option system --user anon && ./scripts/rebuild.py --flake security/casper --option home --user anon 

update:
	nix flake update

gc:
	nix-collect-garbage
