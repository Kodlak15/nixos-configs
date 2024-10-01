#!/usr/bin/env bash

install() {
	flake="$1"
	host="$2"
	nix run github:nix-community/nixos-anywhere -- --flake ".#$flake" "$host" --phases kexec,disko,install,reboot
	# This doesn't seem to work
	# Need to run this once system is re-entered
	# ssh "$1" -t command "systemd-cryptenroll --fido2-device=auto $2 && echo rebooting... && sleep 5 && reboot"
}

case "$1" in
rift) install "rift" "rift" ;;
*) echo "Invalid flake: $flake" ;;
esac
