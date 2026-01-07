#!/usr/bin/env bash

# ---------------------------------
# Variables
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
PKGS_FILE="$SCRIPT_DIR/cargo.packages"


# ---------------------------------
# Functions
prefix_output() {

  while IFS= read -r line; do       
      printf ' > %s\n' "$line"
  done
  
}

# ---------------------------------
# Installing
echo -e "installing cargo packages ..."

#xargs -a "$PKGS_FILE" -r -I{} sh -c 'cargo install "{}" 2>&1 | prefix_output'
xargs -a "$PKGS_FILE" -r -I{} sh -c 'cargo install "{}" 2>&1' | prefix_output

