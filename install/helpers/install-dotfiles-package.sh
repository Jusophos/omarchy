#!/usr/bin/env bash
# @describe install a dotfiles stow package into the system
# @option --config_name     The local config name
# @flag -v --verbose        Show more output
# @flag -d --dryrun         Dont make any file wirting operations
# @arg stow_package!        The name of the stow package 

eval "$(argc --argc-eval "$0" "$@")"
echo ""

#-----------------------------------------
# Functions
usage() {

  bash "$0" --help
  exit 0
}

#-----------------------------------------
# Variables

local_config_name="$argc_stow_package"

if [[ ! -z "$argc_config_name" ]]; then
  
  local_config_name="$argc_config_name"

fi


STOW_PACKAGE="$argc_stow_package"
DOTFILES_REPO="$HOME/.dotfiles"
DOFTILES_STOW_DIR="$DOTFILES_REPO/$STOW_PACKAGE"
CONFIG_DIR="$HOME/.config/$local_config_name"

(( $argc_verbose )) && echo "ℹ  stow package:       $STOW_PACKAGE"
(( $argc_verbose )) && echo "ℹ  stow package path:  $DOFTILES_STOW_DIR"
(( $argc_verbose )) && echo "ℹ  dotfiles repo:      $DOTFILES_REPO"
(( $argc_verbose )) && echo "ℹ  config directory:   $CONFIG_DIR"
(( $argc_verbose )) && echo ""

#-----------------------------------------
# Checks

if [[ ! -d "$DOTFILES_REPO" ]]; then
  echo ""
  echo "❌ dotfiles repository is missing. cirtical error!"
  echo "  ↪ exiting ..."
  echo ""
  exit 1
fi

if [[ ! -d "$DOFTILES_STOW_DIR" ]]; then
  echo ""
  echo "❌ stow package not found in dotfiles repository."
  echo "  ↪ exiting ..."
  echo ""
  exit 1
fi

#-----------------------------------------
# Installation

echo "⚙  installing waybar dotfiles ..."



if [[ -d "$CONFIG_DIR" ]]; then
  if ! gum confirm "A waybar config already exists. It is required to remove it. Continue?"; then
    echo ""
    echo "⚠ user skipped removal."
    echo "  ↪ exiting ..."
    echo ""
    exit 1
  fi

  echo ""
  echo "👷 removing existing config directory ..."

  (( $argc_dryrun )) && echo "🧘 [DRY RUN] rm -R $CONFIG_DIR" || rm -R "$CONFIG_DIR"
fi

echo ""
echo "🔗 linking with stow dotfiles ..."

cd "$DOTFILES_REPO"

if (( $argc_dryrun )); then
  echo "🧘 [DRY RUN] stow -vR -t $HOME" "$STOW_PACKAGE"
else
  stow -vR -t "$HOME" "$STOW_PACKAGE"
fi
