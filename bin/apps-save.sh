#!/usr/bin/env bash
# @describe             Store applicatoins from local folder to repository
# @flag -a --all        Store all available apps and do not choose
# @flag -w --overwrite  Overwrite files in repo if they exists
# @flag -v --verbose    Show detailed output
# @flag -d --dryrun     Do not make any write operations
# @flag --nogit         Do not perform any git operations

eval "$(argc --argc-eval "$0" "$@")"

echo ""
echo "🐧 STORE YOUR APPLICATIONS SCRIPT"
echo ""


# ---------------------------------------
# Variables
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
APPS_DIR="$HOME/.local/share/applications"
REPO_BASE_DIR="$HOME/.omarchy"
REPO_DIR="$REPO_BASE_DIR/applications"

apps=()
copied_files=()

# ---------------------------------------
# List folder
while IFS= read -r -d '' file; do
  
  perms=$(stat -c '%A' "$file")   # z.B. -rwxr-xr-x
  if [[ "${perms:9:1}" == "x" || "${perms:9:1}" == "t" ]]; then
  
    apps+=("$(basename "$file")")

  fi
done < <(find "$APPS_DIR" -maxdepth 1 -type f -print0)

# ---------------------------------------
# Let the user choose

echo "🏗  choose your local apps, which you want to store: "
echo ""

if (($argc_all)); then

  echo "📦 you used '-all' flag -> all apps will be stored"
  choices=("${apps[@]}")
  
else

  mapfile -t choices < <(gum choose --no-limit "${apps[@]}") || exit 1

  if [[ -z "$choices" ]]; then
    
    echo "🪹 nothing selected."
    echo "     ↪ exiting ..."
    exit 1

  fi

fi

  
# ---------------------------------------
# Copy the files

echo "⚙  copy files to repository ..."
(( $argc_verbose )) && echo "  ↪ $REPO_DIR"

for filename in "${choices[@]}"; do

  if [[ -z "$filename" ]]; then
    echo "⚠ [safty] \$filename is empty, skipping ..."
    continue
  fi

  icon_file_name=${filename/.desktop/}
  repo_file="$REPO_DIR/$filename"
  repo_file_icon="$REPO_DIR/icons/$icon_file_name.png"
  source_file="$APPS_DIR/$filename"
  source_file_icon="$APPS_DIR/icons/$icon_file_name.png"

  if [[ -f "$repo_file" && ! (($argc_overwrite)) ]]; then
    
    echo "➡  [skipping] $filename"
    continue
  fi


  if (( $argc_dryrun )); then

    echo "➡  [dryrun]   $filename"

  else

    echo "➡  [copying]  $filename" 
    cp "$source_file" "$repo_file"
    copied_files+=("$repo_file")
    
  fi

  (( $argc_verbose)) && echo "  ↪ $source_file -> $repo_file"

  if [[ -f "$source_file_icon" ]]; then

    if (( ! ${argc_dryrun:-0} )); then

      cp "$source_file_icon" "$repo_file_icon"
      copied_files+=("$repo_file_icon")

    fi

    (( $argc_verbose )) && echo "  ↪ $source_file_icon -> $repo_file_icon"

  fi


done


# ---------------------------------------
# Git operations

echo ""

if (( $argc_nogit )); then

  echo "🤓 no git flag set. no operations will be performed."
  echo "  ↪ exiting ..."
  exit 1

else

  echo "🤓 performing git operations to save repository ..."
  
  echo "-------------------------------"
  echo ""

  cd "$REPO_BASE_DIR"

  git pull

  for file in "${copied_files[@]}"; do

    git add "$file"
    git commit -m "auto(applications): store file" "$file" 

  done

  git push origin main

  echo "-------------------------------"

fi

gum style \
  --border rounded \
  --padding "1 2" \
  --margin "1 0" \
  --align center \
  --bold \
  --foreground 2 \
  "✅ Success!"

