#!/usr/bin/env bash

# Variables
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

echo ""
echo "🍣 installing omarchy tweaks ..."

# Themes
THEME_WAYBAR_IMPORT_LINE="@import \"./waybar.overwrites.css\";"
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


# Hypr Bindings overwrites
HYPR_BINDINGS_OVERWRITES_LINE="source = ~/.config/hypr/bindings.overwrites.conf"
HYPR_BINDINGS_OVERWRITE_FILE="$HOME/.config/hypr/bindings.conf"

echo "  🪟 adding overwrite capabilities to omarchy hypr key bindings ..."

if grep -Fxiq "$HYPR_BINDINGS_OVERWRITES_LINE" -- "$HYPR_BINDINGS_OVERWRITE_FILE"; then

  echo "  🪟 > 🖐 skipping patching, already patched."

else

  if [[ ! -f "$HYPR_BINDINGS_OVERWRITE_FILE" ]]; then
   
    echo "  🪟 > ❌ omarchy bindings file is missing. skipping!"
    echo "    ↪ $HYPR_BINDINGS_OVERWRITE_FILE"

  else
    
    echo "  🪟 > patching hypr keybindings file ..."
    echo "" >> "$HYPR_BINDINGS_OVERWRITE_FILE"
    echo "# DO NOT EDIT OR REMOVE" >> "$HYPR_BINDINGS_OVERWRITE_FILE"
    echo "$HYPR_BINDINGS_OVERWRITES_LINE" >> "$HYPR_BINDINGS_OVERWRITE_FILE"
    echo "    ↪ ✅ file successfully patched!"
    echo "  🪟 > restarting hyprland ..."
    hyprctl reload
  fi
fi


