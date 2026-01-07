#!/usr/bin/env bash
# @describe install zsh config files
# @meta install-level after-auth

eval $(argc --argc-eval "$0" "$@")

# -----------------------
# Variables
DOTFILES_REPO="$HOME/.dotfiles"
SOURCE_LINE="source ~/.config/zsh/custom_config.zsh"
SOURCE_LINE_PROFILE="source ~/.config/zsh/custom_profile.zsh"
CONFIG_FILE="$HOME/.zshrc"
CONFIG_FILE_PROFILE="$HOME/.zprofile"
STOW_PACKAGE="zsh"

# -----------------------
# Checks
if [[ ! -f "$CONFIG_FILE" ]]; then
  echo "(w) .zshrc configuration file does not exists. Creating one ..."
  touch "$CONFIG_FILE"
fi

if [[ ! -f "$CONFIG_FILE_PROFILE" ]]; then
  echo "(w) .zprofile configuration file does not exists. Creating one ..."
  touch "$CONFIG_FILE_PROFILE"
fi

if grep -Fxiq -- "$SOURCE_LINE" "$CONFIG_FILE"; then
  echo "(w) .zshrc configuration is already patched. Skipping ..."
else
  echo "patching .zshrc configuration file ..."

  echo "" >> "$CONFIG_FILE"
  echo "# DO NOT EDIT" >> "$CONFIG_FILE"
  echo "$SOURCE_LINE" >> "$CONFIG_FILE"

  echo "✅ configuration .zshrc succesfully patched."
fi

if grep -Fxiq -- "$SOURCE_LINE_PROFILE" "$CONFIG_FILE_PROFILE"; then
  echo "(w) .zprofile configuration is already patched. Skipping ..."
else
  echo "patching .zprofile configuration file ..."

  echo "" >> "$CONFIG_FILE_PROFILE"
  echo "# DO NOT EDIT" >> "$CONFIG_FILE_PROFILE"
  echo "$SOURCE_LINE_PROFILE" >> "$CONFIG_FILE_PROFILE"

  echo "✅ configuration .zprofile succesfully patched."
fi

# -----------------------
# Linking
echo "installing configuration files ..."

cd "$DOTFILES_REPO"
stow -vR -t "$HOME" "$STOW_PACKAGE"

