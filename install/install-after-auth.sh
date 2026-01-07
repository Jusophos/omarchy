#!/usr/bin/env bash

set -euo pipefail
echo ""

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
  local prefix="  "
  while IFS= read -r line; do
    printf '%s %s\n' "$prefix" "$line"
  done
}

# ----------------------------------------
# Installation
cd "$SCRIPT_DIR"

echo ""
gum style --bold "INSTALL MISC"

./misc/install-dotfiles-repo.sh 2>&1 | prefix_output && echo ""
./misc/install-pngus-lnx.sh 2>&1 | prefix_output && echo ""

echo ""
gum style --bold "INSTALL PNGUS LNX"
./.pngus-lnx/install.sh 2>&1 | prefix_output && echo ""

echo ""
gum style --bold "INSTALL DOTFILES"
./dotfiles/install-zsh-dotfiles.sh 2>&1 | prefix_output && echo ""
./dotfiles/install-ghostty-dotfiles.sh 2>&1 | prefix_output && echo ""
