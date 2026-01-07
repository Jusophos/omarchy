#!/usr/bin/env bash

echo -e "installing pacman packages ..."

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
pckg_file="$SCRIPT_DIR/pacman.packages"

sudo pacman -S --needed --noconfirm - < "$pckg_file"
