#!/usr/bin/env bash

SCRIPT_DIR="$HOME/.dotfiles/_scripts"

echo "enable custom 1password browsers ..."

sudo "$SCRIPT_DIR/enable-custom-1password-browser.sh" "zen-bin"
sudo "$SCRIPT_DIR/enable-custom-1password-browser.sh" "vivaldi-bin"

