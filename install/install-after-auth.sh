#!/usr/bin/env bash

set -euo pipefail
echo ""

# ----------------------------------------
# Setup killing sub processes
cleanup() {
  local code=$?
  trap - INT TERM EXIT

  # If we were interrupted, forward to whole process group
  if [[ $code -eq 130 ]]; then
    echo "Received SIGINT — killing process group"
  else
    echo "Exiting (code=$code) — killing process group"
  fi

  # Send TERM first, then KILL as fallback
  kill -TERM 0 2>/dev/null || true
  sleep 0.2
  kill -KILL 0 2>/dev/null || true

  exit "$code"
}

on_int() { exit 130; }

trap on_int INT
trap cleanup TERM EXIT

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
run_indented_tty ./misc/install-bun.sh && echo ""
run_indented_tty ./misc/install-bun-apps.sh && echo ""
run_indented_tty ./misc/install-1pw-browser-rules.sh && echo ""
run_indented_tty ./misc/install-omarchy-tweaks.sh && echo ""
run_indented_tty ./misc/install-custom-applications.sh && echo ""


echo ""
gum style --bold "INSTALL PNGUS LNX"
run_indented_tty $HOME/.pngus-lnx/install.sh && echo ""

echo ""
gum style --bold "INSTALL DOTFILES"
run_indented_tty ./dotfiles/install-zsh-dotfiles.sh && echo ""
run_indented_tty ./dotfiles/install-ghostty-dotfiles.sh && echo ""
run_indented_tty ./dotfiles/install-waybar-dotfiles.sh && echo ""
run_indented_tty ./dotfiles/install-hypr-dotfiles.sh && echo ""

echo ""
gum style --bold "INSTALL SERVICES"
run_indented_tty ./services/install-syncthing-service.sh && echo ""
