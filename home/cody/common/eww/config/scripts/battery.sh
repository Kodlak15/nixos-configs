#!/usr/bin/env bash

is_charging() {
	if [[ -z $(acpi -b | grep Discharging) ]]; then
		echo true
	else
		echo false
	fi
}

case "$1" in
-r | --remaining) battery_remaining ;;
-c | --charging) is_charging ;;
esac
