#!/usr/bin/env bash

set -euo pipefail


# ----------------------------------------
# Setup traps
if [[ $$ -ne $(ps -o pgid= $$ | tr -d ' ') ]]; then
  exec setsid "$0" "$@"
fi
PGID=$(ps -o pgid= $$ | tr -d ' ')

trap 'echo "Received SIGINT — forwarding to group"; kill -SIGINT -"$PGID" 2>/dev/null || true; exit 130' SIGINT

# ----------------------------------------
# Variables
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"


# ----------------------------------------
# Functions
prefix_output() {
  local prefix="  > "
  while IFS= read -r line; do
    printf '%s %s\n' "$prefix" "$line"
  done
}

# ----------------------------------------
# Installation
cd "$SCRIPT_DIR"

echo -e "INSTALL PACKAGES"
./packages/install-packages-packman.sh 2>&1 | prefix_output
./packages/install-packages-aur.sh 2>&1 | prefix_output

