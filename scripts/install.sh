#!/usr/bin/env bash

set -e

get_host_target_device() {
	cat "./hosts/$1/disk-config.nix" | grep "device = " | head -n 1 | xargs | awk -F ' ' '{print $4}' | rev | cut -c2- | rev
}

run_nixos_anywhere() {
	flake="$1"
	target_host="$2"
	nix run github:nix-community/nixos-anywhere -- \
		--flake ".#$flake" \
		--target-host "$target_host" \
		--generate-hardware-config nixos-generate-config ./hosts/$flake/hardware-configuration.nix
}

install() {
	flake="$1"
	target_host="$2"
	if [ -z "$flake" ]; then
		echo "Usage: install --flake <flake> --target root@<target>"
		return 1
	fi
	if [ -z "$target_host" ]; then
		target_host="$flake"
	fi
	target_device="$(get_host_target_device "$target_host")"
	echo "Installing NixOS with nixos-anywhere:"
	echo "Flake: $flake"
	echo "Target host: $target_host"
	echo "Target device: $target_device"
	echo "WARNING: the chosen device will be wiped!"
	read -p "Are you sure you want to install to $target_device? (y/n) " -n 1 -r
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		run_nixos_anywhere "$flake" "root@$target_host"
	fi
}

install "$1" "$2"