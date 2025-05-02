#!/usr/bin/env bash

set -e

if sudo nix flake update; then
	git add .
	git commit -m "Update flake"
fi
