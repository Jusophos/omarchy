#!/usr/bin/env bash

THEMES_DIR="$HOME/.config/omarchy/themes"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
LOCAL_DIR=$(realpath "$SCRIPT_DIR/../../themes")

echo "🎨 installing custom themes ..."

echo "  ↪ pngu-catppuccin"
ln -sv "$LOCAL_DIR/pngu-catppuccin" "$THEMES_DIR/pngu-catppuccin"

echo "  ↪ pngu-catppuccin-latte"
ln -sv "$LOCAL_DIR/pngu-catppuccin-latte" "$THEMES_DIR/pngu-catppuccin-latte"
