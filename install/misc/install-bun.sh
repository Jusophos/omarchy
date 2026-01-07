#!/usr/bin/env bash

echo ""
echo "⚙  installing bun ..."

if bun --version > /dev/null; then

  echo " ↪ already installed. exiting ..."
  exit 1
fi

curl -fsSL https://bun.com/install | bash
