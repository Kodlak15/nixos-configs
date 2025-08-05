# Nix commands
update:
	./scripts/update.sh
cg:
	sudo nix-collect-garbage -d

# Skyrim (Personal laptop)
install-skyrim:
	./scripts/install.sh skyrim
skyrim:
	sudo nixos-rebuild switch --flake ".#skyrim"
	find "$(HOME)" -type f -name "*.hm.bk" -delete
	home-manager switch -b "hm.bk" --flake ".#cody@skyrim"
skyrim-nixos:
	sudo nixos-rebuild switch --flake ".#skyrim"
skyrim-home:
	find "$(HOME)" -type f -name "*.hm.bk" -delete
	home-manager switch -b "hm.bk" --flake ".#cody@skyrim"

# Cyrodil (Personal desktop)
install-cyrodil:
	./scripts/install.sh cyrodil
cyrodil:
	sudo nixos-rebuild switch --flake ".#cyrodil"
	find "$(HOME)" -type f -name "*.hm.bk" -delete
	home-manager switch -b "hm.bk" --flake ".#cody@cyrodil"
cyrodil-nixos:
	sudo nixos-rebuild switch --flake ".#cyrodil"
cyrodil-home:
	find "$(HOME)" -type f -name "*.hm.bk" -delete
	home-manager switch -b "hm.bk" --flake ".#cody@cyrodil"

# rift
install-rift:
	./scripts/install.sh rift
rift:
	sudo nixos-rebuild switch --flake ".#rift"
rift-nixos:
	sudo nixos-rebuild switch --flake ".#rift"
