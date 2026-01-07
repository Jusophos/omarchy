#!/usr/bin/env bash
# @describe Install personal dotfiles repository
# @meta install_level AFTER AUTH

eval "$(argc --argc-eval "$0" "$@")" 

GITHUB_REPO="git@github.com:Jusophos/dotfiles.git"
LOCAL_FOLDER="$HOME/.dotfiles"

echo "installing personal dotfiles repository ..."

if [[ -d "$LOCAL_FOLDER" ]]; then
  echo "(x) dotfiles folder locally already exists. skipping ..."
  exit 1
fi



echo "cloning github repository ..."

git clone "$GITHUB_REPO" "$LOCAL_FOLDER"

echo ""

MSG="✅ Done! Dotfiles repository installed."
gum style \
  --border rounded \
  --padding "1 4" \
  --align center \
  --width 60 \
  "$MSG"

echo ""
