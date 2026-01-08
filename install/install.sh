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

BOLD="$(printf '\033[1m')"
RESET="$(printf '\033[0m')"

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

cd "$SCRIPT_DIR"

# ----------------------------------------
# Installation: packages

printf '%s%s%s\n\n' "$BOLD" "INSTALL PACKAGES" "$RESET"

run_indented_tty ./packages/install-packages-packman.sh && echo ""
run_indented_tty ./packages/install-packages-aur.sh && echo ""
run_indented_tty ./packages/install-packages-cargo.sh && echo ""

# ----------------------------------------
# Installation: custom packages installations

run_indented_tty ./packages/install-tgt.sh && echo ""
