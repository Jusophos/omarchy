#!/usr/bin/env bash

# Variables
LIB_PATH_TARGET="/usr/lib/libunwind.so.1"
LIB_PATH_ORIG="/usr/lib/libunwind.so.8"

echo ""
echo "installing tgt from cargo repository ..."

cargo install tgt --locked

if [[ -f "$LIB_PATH_TARGET" ]]; then
  echo "ℹ  Lib is already linked and existing."  
  echo "  ↪ $LIB_PATH_TARGET"
  echo "  ↪ skipping patching ..."
  echo ""
  exit 0
fi


if [[ ! -f "$LIB_PATH_ORIG" ]]; then

  echo "❌ Lib is missing, which could be linked ..."
  echo " ↪ $LIB_PATH_ORIG"
  echo " ↪ installation failed. exiting ..."
  echo ""
  exit 1
fi

echo "linking library ..."
sudo ln -s "$LIB_PATH_ORIG" "$LIB_PATH_TARGET"
