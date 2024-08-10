#!/usr/bin/env bash

update() {
	sops updatekeys ./hosts/skyrim/secrets.yaml
	sops updatekeys ./hosts/morrowind/secrets.yaml
}

case "$1" in
--update) update ;;
*) echo "Invalid option" ;;
esac
