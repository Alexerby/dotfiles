#!/bin/bash

error_exit() {
    echo "Error: $1" >&2
    exit 1
}

create_symlink_dir() {
    source_dir="$1"
    target_dir="$2"

    [ -d "$source_dir" ] || error_exit "Source directory $source_dir not found"

    mkdir -p "$target_dir" || error_exit "Failed to create target directory $target_dir"
    ln -sf "$source_dir"/* "$target_dir" || error_exit "Failed to create symbolic links"
}

create_symlink_dir "$HOME/dotfiles/.config" "$HOME/.config/"
create_symlink_dir "$HOME/dotfiles/bin" "$HOME/bin/"
create_symlink_dir "$HOME/dotfiles/Background Images" "$HOME/Pictures/Background Images/"
