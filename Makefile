# Nix commands
update-flake:
	sudo nix flake update
collect-garbage:
	sudo nix-collect-garbage -d

# Skyrim (Personal laptop)
install-skyrim:
	./scripts/install.sh skyrim
rebuild-skyrim:
	./scripts/rebuild.py --option "full" --host "skyrim" --user "cody" --target-host "root@skyrim"
rebuild-skyrim-nixos:
	./scripts/rebuild.py --option "nixos" --host "skyrim" --target-host "root@skyrim"
rebuild-skyrim-nixos-remote:
	./scripts/rebuild.py --option "nixos" --host "skyrim" --target-host "cody@skyrim" --build-host "cyrodil"
rebuild-skyrim-home:
	./scripts/rebuild.py --option "home" --host "skyrim" --user "cody"

# Cyrodil (Personal desktop)
install-cyrodil:
	./scripts/install.sh cyrodil
rebuild-cyrodil:
	./scripts/rebuild.py --option "full" --host "cyrodil" --user "cody" --target-host "root@cyrodil"
rebuild-cyrodil-nixos:
	./scripts/rebuild.py --option "nixos" --host "cyrodil" --target-host "root@cyrodil"
rebuild-cyrodil-home:
	./scripts/rebuild.py --option "home" --host "cyrodil" --user "cody"

# Valenwood (Test VM)
install-valenwood:
	./scripts/install.sh valenwood
rebuild-valenwood:
	./scripts/rebuild.py --option "full" --host "valenwood" --user "cody" --target-host "root@valenwood"
rebuild-valenwood-nixos:
	./scripts/rebuild.py --option "nixos" --host "valenwood" --target-host "root@valenwood"
rebuild-valenwood-nixos-remote:
	./scripts/rebuild.py --option "nixos" --host "valenwood" --target-host "cody@valenwood" --build-host "cyrodil"
rebuild-valenwood-home:
	./scripts/rebuild.py --option "home" --host "valenwood" --user "cody"
