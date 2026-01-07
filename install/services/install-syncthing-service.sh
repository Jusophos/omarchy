#!/usr/bin/env bash

echo ""
echo "🛠 installing syncthing service ..."

sudo systemctl enable --now "syncthing@$USER.service"

echo "✅ syncthing succesfully installed & enabled"
