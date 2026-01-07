#!/usr/bin/env bash
# @describe install waybar dotfiles
# @meta install-level after-auth

eval $(argc --argc-eval "$0" "$@")
echo ""

# Variables
STOW_PACKAGE="waybar"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
HELPERS=$(realpath "$SCRIPT_DIR/../helpers")

"$HELPERS/install-dotfiles-package.sh" "$STOW_PACKAGE" 
