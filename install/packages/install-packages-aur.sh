#!/usr/bin/env bash

# ---------------------------------
# Variables
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
PKGS_FILE="$SCRIPT_DIR/aur.packages"

# ---------------------------------
# Installing
echo -e "installing AUR packages ..."

yay -S --needed --noconfirm - < "$PKGS_FILE"
