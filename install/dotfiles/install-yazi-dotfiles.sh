#!/usr/bin/env bash
# @describe install yazi dotfiles
# @meta install-level after-auth

eval $(argc --argc-eval "$0" "$@")
echo ""

# Variables
STOW_PACKAGE="yazi"
STOW_BACKUP="$HOME/.dotfiles/_scripts/stow-bak.sh"

#"$HELPERS/install-dotfiles-package.sh" "$STOW_PACKAGE" --noconfirm
"$STOW_BACKUP" "$STOW_PACKAGE"
