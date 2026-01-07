#!/usr/bin/env bash

# ---------------------------------
# Variables
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
PKGS_FILE="$SCRIPT_DIR/aur.packages"


# ---------------------------------
# Functions
prefix_output() {

  while IFS= read -r line; do       
      printf ' > %s\n' "$line"
  done
  
}

# ---------------------------------
# Installing
echo -e "installing AUR packages ..."

yay -S --needed --noconfirm - < "$PKGS_FILE" 2>&1 | prefix_output
