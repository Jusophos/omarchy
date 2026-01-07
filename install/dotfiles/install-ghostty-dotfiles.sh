#!/usr/bin/env bash
# @describe install ghostty with zsh and zsh configs

eval $(argc --argc-eval "$0" "$@")

# --------------------------
# Variables
DOTFILES_REPO="$HOME/.dotfiles"
GHOSTTY_CONFIG="$HOME/.config/ghostty/config"
SOURCE_LINE="config-file = ?\"~/.config/ghostty/custom.conf\""
STOW_PACKAGE="ghostty-omarchy"

# --------------------------
# Checks 

if [[ ! -d "$DOTFILES_REPO" ]]; then
  echo "(x) dotfiles repository is not installed. exiting ..."
  exit 1
fi

if [[ ! -f "$GHOSTTY_CONFIG" ]]; then
  echo "(w) ghostty config does not exist. creating one ..."

  touch $GHOSTTY_CONFIG
fi


# --------------------------
# Patching ghostty file 

echo "patching ghostty configuration file ..."

if grep -Fxiq -- "$SOURCE_LINE" "$GHOSTTY_CONFIG"; then

  echo "(w) ghostty config is already patched. skipping patch ..."

else
  
  echo "" >> $GHOSTTY_CONFIG
  echo "# DO NOT EDIT THIS PART" >> $GHOSTTY_CONFIG
  echo "$SOURCE_LINE" >> $GHOSTTY_CONFIG

  echo "✅ configuration succesfully patched."

fi


# --------------------------
# Stow configuration
echo ""
echo "installing ghostty custom configuration"

cd $DOTFILES_REPO
stow -v -t "$HOME" -R "$STOW_PACKAGE"

echo "✅ configuration succesfully installed with stow."
echo ""
echo "ℹ  you need to restart the shell to see changes."
