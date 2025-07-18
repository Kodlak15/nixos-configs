#!/usr/bin/env bash

set -e

if sudo nix flake update; then
	git add "flake.lock"
	git commit -m "Update flake"
fi
