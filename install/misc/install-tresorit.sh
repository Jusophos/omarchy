#!/usr/bin/env bash

echo "⚙  installing tresorit ..."

if [[ -d "$HOME/.local/share/tresorit" ]]; then

	echo "ℹ  tresorit is already installed! exiting ..."
	exit 0
fi

MY_TMP=$(mktemp -d)
FILE="$MY_TMP/tresorit-installer.run"

trap 'rm -rf "$MY_TMP"; echo " Cleanup done."' EXIT

echo "▼ downloading ..."
curl -L "https://installer.tresorit.com/tresorit_installer.run" -o "$FILE"

chmod +x "$FILE"
"$FILE"
