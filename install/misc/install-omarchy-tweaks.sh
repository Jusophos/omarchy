#!/usr/bin/env bash

# Variables
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

echo ""
echo "🍣 installing omarchy tweaks ..."

# Themes
THEME_WAYBAR_IMPORT_LINE="@import \"../omarchy/current/theme/waybar.overwrite.css\";"
THEME_WAYBAR_CSS_FILE="$HOME/.config/waybar/style.css"

echo "  🎨 adding overwrite capabilities to omarchy themes ( waybar ) ..."

if grep -Fxiq "$THEME_WAYBAR_IMPORT_LINE" -- "$THEME_WAYBAR_CSS_FILE"; then

  echo "  🎨 > 🖐 skipping patching, already patched."

else

  if [[ ! -f "$THEME_WAYBAR_CSS_FILE" ]]; then
   
    echo "  🎨 > ❌ omarchy waybar file is missing. skipping!"
    echo "    ↪ $THEME_WAYBAR_CSS_FILE"

  else
    
    echo "  🎨 > patching waybar style css of omarchy ..."
    echo "" >> "$THEME_WAYBAR_CSS_FILE"
    echo "/* DO NOT EDIT OR REMOVE */" >> "$THEME_WAYBAR_CSS_FILE"
    echo "$THEME_WAYBAR_IMPORT_LINE" >> "$THEME_WAYBAR_CSS_FILE"
    echo "    ↪ ✅ file successfully patched!"

  fi
fi
