#!/usr/bin/env bash
# @describe install dotfiles für neovim ( omarchy version )
# @meta install-level after-auth

eval $(argc --argc-eval "$0" "$@")

# Variables
NVIM_CONFIG="$HOME/.config/nvim"
DOTFILES_REPO="$HOME/.dotfiles"
STOW_PACKAGE="nvim-omarchy"

if [[ -d "$NVIM_CONFIG" ]]; then

	echo ""
    	gum style --bold "⚠ THERE IS ALREADY A NVIM CONFIG."
	echo ""
	if ! gum confirm "Overwrite the config ( is required! ) ?"; then

		echo ""
		gum style --bold --foreground="red" "⨯ CANCELED!"
		echo ""
		read -p "Press Enter to exit ..."
		exit 1
	fi
	
	echo "removing existing nvim folder ..."
	rm -R "$NVIM_CONFIG"
	echo "  > successfully removed"
fi

echo "installing configuration with stow ..."

cd "$DOTFILES_REPO"
if ! stow -vR -t "$HOME" "$STOW_PACKAGE"; then

	msg="❌ STOW FAILED! Exiting ..."

	w=$(( ${#msg} + 2*4 + 2 ))

	gum style \
	--border rounded \
	--padding "1 4" \
	--align center \
	--width "$w" \
	"$msg"
	exit 1
fi
	
msg="✅ Done! installation successful."

w=$(( ${#msg} + 2*4 + 2 ))

gum style \
  --border rounded \
  --padding "1 4" \
  --align center \
  --width "$w" \
  "$msg"

