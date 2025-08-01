#!/usr/bin/env bash

DOTFILES="$HOME/.dotfiles"

# Comma separated list of stow folders
STOW_FOLDERS="nvim,tmux,zsh,zathura,alacritty"

# cd to dotfiles directory
cd "$DOTFILES" || {
  echo "Failed to change to $DOTFILES"
  exit 1
}

# Convert comma-separated string to array
IFS=',' read -ra folders <<< "$STOW_FOLDERS"

# Loop through and stow each
for folder in "${folders[@]}"; do
    echo "Stowing $folder..."
    stow -D "$folder" 2>/dev/null
    stow "$folder"
done

