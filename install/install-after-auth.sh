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
run_indented_tty() {
  # Run command under a pseudo-terminal so colors/prompts keep working
  local cmd_str
  cmd_str="$(printf '%q ' "$@")"
  script -qefc "$cmd_str" /dev/null | prefix_output
}
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

run_indented_tty ./misc/install-dotfiles-repo.sh && echo ""
run_indented_tty ./misc/install-pngus-lnx.sh && echo ""
run_indented_tty ./misc/install-tresorit.sh && echo ""
run_indented_tty ./misc/install-omarchy-themes.sh && echo ""
run_indented_tty ./misc/install-omarchy-custom-themes.sh && echo ""

echo ""
gum style --bold "INSTALL PNGUS LNX"
run_indented_tty $HOME/.pngus-lnx/install.sh && echo ""

echo ""
gum style --bold "INSTALL DOTFILES"
run_indented_tty ./dotfiles/install-zsh-dotfiles.sh && echo ""
run_indented_tty ./dotfiles/install-ghostty-dotfiles.sh && echo ""
run_indented_tty ./dotfiles/install-waybar-dotfiles.sh && echo ""

echo ""
gum style --bold "INSTALL SERVICES"
run_indented_tty ./services/install-syncthing-service.sh && echo ""
