#!/usr/bin/env bash
# @describe install pngus scripts
# @meta install-level basic
# @meta source git@github.com:Jusophos/pngus-lnx.git

eval $(argc --argc-eval "$0" "$@")
echo ""

# Variables
GIT_REPO="git@github.com:Jusophos/pngus-lnx.git"
LOCAL_FOLDER="$HOME/.pngus-lnx"

# Checks
if [[ -d "$LOCAL_FOLDER" ]]; then

  echo "ℹ  repository is already existant and installed."
  echo "  ↪ exiting ..."
  exit 1
fi

echo "⚙  cloning pngus-lnx repository ..."
if ! git clone "$GIT_REPO" "$LOCAL_FOLDER"; then

    echo ""
    echo "❌ cloning failed!"
    echo "↪ exiting ..."
    exit 1

fi

echo ""
echo "✅ pngus-lnx successfully installed"
echo ""
