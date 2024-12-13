#!/usr/bin/env sh

rebuild_nixos_local() {
	nixos-rebuild switch --flake ".#$1" --target-host "$1" --build-host cody@localhost --max-jobs auto
}

rebuild_nixos_remote() {
	nixos-rebuild switch --flake ".#$1" --target-host "$1" --build-host "$1" --max-jobs auto
}

case "$2" in
--local) rebuild_nixos_local "$1" ;;
--remote) rebuild_nixos_remote "$1" ;;
*) rebuild_nixos_local "$1" ;;
esac
