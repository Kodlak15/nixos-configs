#!/usr/bin/env bash

set -e

DIRECTORY="/tmp/eww/mullvad"
STATUS="$DIRECTORY/status"
SERVER="$DIRECTORY/server"

mkdir -p "$DIRECTORY"
touch "$STATUS"
touch "$SERVER"

connect() {
	mullvad connect || {
		echo "VPN failed to connect"
		exit 1
	}

	echo "connected" >"$STATUS"
}

disconnect() {
	mullvad disconnect || {
		echo "VPN failed to disconnect"
		exit 1
	}

	echo "disconnected" >"$STATUS"
}

toggle() {
	if mullvad status | grep -q "Connected"; then
		disconnect
	else
		connect
	fi
}

status() {
	inotifywait -m -e close_write "$STATUS" | while read -r _ _; do
		tail -n 1 "$STATUS"
	done
}

case "$@" in
"--connect") connect ;;
"--disconnect") disconnect ;;
"--toggle") toggle ;;
"--server") server ;;
"--status") status ;;
esac
