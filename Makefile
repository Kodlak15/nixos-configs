everest:
	powder --config nixos --system everest rebuild

denali:
	powder --config nixos --system denali rebuild

everest-home:
	powder --config home-manager --system everest rebuild

denali-home:
	powder --config home-manager --system denali rebuild

everest-full:
	powder --config all --system everest rebuild

denali-full:
	powder --config all --system everest rebuild

update:
	nix flake update

gc:
	nix-collect-garbage
