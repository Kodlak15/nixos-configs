#!/usr/bin/env bash

mount_boot_partition() {
	if ! cat </proc/mounts | grep -q "boot"; then
		sudo mount "/dev/disk/by-label/EFI-NIXOS" "/boot" || exit 1
	fi
}

get_host_type() {
	hostnamectl chassis | xargs
}

rebuild_nixos() {
	mount_boot_partition
	sudo nixos-rebuild switch --flake ".#$(hostname)/$(get_host_type)" --max-jobs auto
	sudo umount "/boot"
}

rebuild_home() {
	home-manager switch --flake ".#$(whoami)@$(hostname)/$(get_host_type)" --max-jobs auto
}

case "$1" in
--nixos) rebuild_nixos ;;
--home) rebuild_home ;;
--all) rebuild_nixos && rebuild_home ;;
*) echo "Invalid option selected" ;;
esac
