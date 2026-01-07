#!/usr/bin/env bash
# @flag -v --verbose    Show more detailed information
# @flag --nogit        Do not perform git actions
# @option --source      The source to add from. arch,aur,flatpak. Default: arch
# @arg package          The name of the package

eval "$(argc --argc-eval "$0" "$@")"

# Function to run when Ctrl+C is pressed
cleanup() {
  echo -e "\n[!] Ctrl+C detected. Shutting down all processes..."

  # Kill the entire process group
  # The '-' before $$ targets the group ID instead of just the PID
  kill -TERM -$$ 2>/dev/null
}

# 'trap' catches the SIGINT signal (Ctrl+C) and runs the cleanup function
trap cleanup SIGINT

# Variables
SCRIPT_PATH=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
INSTALL_DIR=$(realpath "$SCRIPT_PATH/../install")
PKG_FILE="$INSTALL_DIR/packages/pacman.packages"
GIT_REPO=$(realpath "$SCRIPT_PATH/../")
ADD_COMMAND=(sudo pacman -S)
SOURCE="arch"
if [[ $argc_source == "flatpak" ]]; then

  PKG_FILE="$INSTALL_DIR/flathub-packages.txt"
  ADD_COMMAND=(flatpak install)
  SOURCE="flatpak"
  echo "(i) source:   flatpak"

elif [[ $argc_source == "aur" ]]; then

  PKG_FILE="$INSTALL_DIR/aur-packages.txt"
  ADD_COMMAND=(yay -S --noconfirm)
  SOURCE="aur"
  echo "(i) source:   aur"

else

  echo "(i) source:   arch"

fi

(($argc_verbose)) && echo "(i) pkg file: $PKG_FILE"

# Usage
usage() {

  echo ""
  $0 --help
}

# Package file

if [[ ! -f $PKG_FILE ]]; then
  echo "(x) package file for arch repo is missing !"
  echo "      > $PKG_FILE"
  echo "(x) exiting ..."
  exit 1
fi

if [[ -z $argc_package ]]; then
  echo "(x) package name as argument is missing!"
  echo "(x) exiting to usage ..."

  usage
  exit 1
fi

(($argc_verbose)) && echo "(i) pkg name: $argc_package"

package_list=$(<"$PKG_FILE")

if printf '%s\n' "$package_list" | grep -Fqx -- "$argc_package"; then

  echo "(x) package already exists in list: $argc_package"
  echo "(x) exiting ..."
  exit 1

else

  if [[ -n "$package_list" ]]; then

    package_list+=$'\n'"$argc_package"

  else

    package_list+="$argc_package"

  fi

fi

(($argc_verbosec)) && echo "(i) executing directly add command ..."
if ! "${ADD_COMMAND[@]}" "$argc_package"; then
  echo "(x) installation not successfull"
  echo "(x) skipping update of package file"
  echo "(x) exiting ..."
  exit 1
fi

(($argc_verbosec)) && echo "(i) saving added package list ..."
echo "$package_list" >$PKG_FILE
#echo "$package_list"

echo "(i) $argc_package added to file"

if [[ -z $argc_nogit ]]; then
  (($argc_verbose)) && echo "(i) performing git actions ..."

  cd "$GIT_REPO"

  (($argc_verbose)) && echo "(i) executing git commit install/$(basename $PKG_FILE) -m ..."

  echo ""

  git commit "install/packages/$(basename $PKG_FILE)" -m "auto(pkg-add/$SOURCE): add $argc_package package"
  git push origin main
fi
