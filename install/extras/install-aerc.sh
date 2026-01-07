#!/usr/bin/env bash

echo ""
echo "installing aerc dotfiles ..."

# Variables
STOW_PACKAGE="aerc"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
HELPERS=$(realpath "$SCRIPT_DIR/../helpers")

"$HELPERS/install-dotfiles-package.sh" "$STOW_PACKAGE" --noconfirm



echo "init pass"
echo "setting password for richard@jung.ai GMAIL..."
secret-tool store --label="Aerc Email RJ" service aerc account richard@jung.ai
echo "password stored."

echo "setting password for richard@whiteblack.com GMAIL..."
secret-tool store --label="Aerc Email WB" service aerc account richard@whiteblack.com
echo "password stored."
