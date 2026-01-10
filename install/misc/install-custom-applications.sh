#!/usr/bin/env bash
# @meta install-level after-auth

echo ""


# Variables
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
APPS_DIR="$HOME/.omarchy/applications"
APPS_DIR_TARGET="$HOME/.local/share/applications"
ICONS_DIR="$APPS_DIR/icons"
ICONS_DIR_TARGET="$APPS_DIR_TARGET/icons"

apps=()
icons=()

# Reading existing applications & icons
while IFS= read -r -d '' file; do

  apps+=("$file")

done < <(find "$APPS_DIR" -maxdepth 1 -type f -print0)

while IFS= read -r -d '' file; do

  icons+=("$file")

done < <(find "$ICONS_DIR" -maxdepth 1 -type f -print0)

# Copy

echo "⚙  install and restore applications entry from repository ..."

echo "⚙  installing apps ..."
for file in "${apps[@]}"; do

  target_file="$APPS_DIR_TARGET/$(basename "$file")"
  echo "  🚛 applications/$(basename "$file") -> $target_file"
  cp "$file" "$target_file"

done

echo ""
echo "⚙  installing icons ..."

for file in "${icons[@]}"; do

  target_file="$ICONS_DIR_TARGET/$(basename "$file")"
  echo "  🚛 applications/icons/$(basename "$file") -> $target_file"
  cp "$file" "$target_file"

done

echo ""
echo "✅ apps and icons restored."
