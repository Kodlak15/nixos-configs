everest:
	powder --option nixos --system everest --command rebuild

denali:
	powder --option nixos --system denali --command rebuild

everest-home:
	powder --option home-manager --system everest --command rebuild

denali-home:
	powder --option home-manager --system denali --command rebuild

everest-full:
	powder --option all --system everest --command rebuild

denali-full:
	powder --option all --system everest --command rebuild

update:
	nix flake update

gc:
	nix-collect-garbage
