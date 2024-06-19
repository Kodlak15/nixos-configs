everest:
	powder --option nixos --system everest rebuild

denali:
	powder --option nixos --system denali rebuild

everest-home:
	powder --option home-manager --system everest rebuild

denali-home:
	powder --option home-manager --system denali rebuild

everest-full:
	powder --option all --system everest rebuild

denali-full:
	powder --option all --system everest rebuild

update:
	nix flake update

gc:
	nix-collect-garbage
