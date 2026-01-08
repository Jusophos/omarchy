#!/usr/bin/env bash
# @describe install hypr dotfiles
# @meta install-level after-auth

eval $(argc --argc-eval "$0" "$@")
echo ""

# Variables
STOW_PACKAGE="hypr-omarchy"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
HELPERS=$(realpath "$SCRIPT_DIR/../helpers")
LOCAL_PATH="$HOME/.config/hypr"
DOTFILES_STOW_BAK="$HOME/.dotfiles/_scripts/stow-bak.sh"

echo "installing hypr omarchy links ..."

"$DOTFILES_STOW_BAK" "$STOW_PACKAGE"

echo "✅ succesfully installed."
echo "🔃 restarting hyprland"

hyprctl reload
