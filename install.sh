#!/bin/bash

# Functions

function prompt_and_link {
	echo
    read -p "Do you want to create a symbolic link from $1 to $2? (y/n): " answer

    case $answer in
        [yY])
            ln -s "$(realpath "$1")" "$2"
            echo_green "Symbolic link created successfully."
            ;;
        [nN])
            echo_red "Link creation aborted."
            ;;
        *)
            echo_red "Invalid input. Link creation aborted."
            ;;
    esac
}


function echo_warning {
    echo -e "\e[91mWARNING: $1\e[0m"
}

function echo_red {
    echo -e "\e[91m$1\e[0m"
}

function echo_green {
    echo -e "\e[32m$1\e[0m"
}

function make_dir {
    if [ -d "$1" ]; then
        echo "Directory '$1' already exists."
    else
        mkdir -p "$1"
        echo "Created directory: $(realpath "$1")"
    fi
}

function link_resource {
    echo "Linking $(realpath "$1") to $(realpath "$2")"
    ln -s "$1" "$2"
}



# Installation

function install_zathura {
	echo 
	read -p "Do you want to link Zathura (PDF reader)? (y/n): " zathura_answer

    case $zathura_answer in
        [yY])
			echo
            make_dir -p "$HOME/.config/zathura"
            link_resource -s "zathurarc" "$HOME/.config/zathura/zathurarc"
            ;;
        [nN])
            echo_red "Zathura setup skipped."
            ;;
        *)
            echo_red "Invalid input. Zathura setup skipped."
            ;;
    esac
}

function link_directory_recursively {
    source_dir="$1"
    target_dir="$2"

    # Create the target directory if it doesn't exist
    mkdir -p "$target_dir"

    # Iterate through files and directories in the source directory
    for entry in "$source_dir"/*; do
        # Extract the basename (file or directory name)
        base_name=$(basename "$entry")

        # Create the symbolic link in the target directory
        ln -s "$(realpath "$entry")" "$target_dir/$base_name"
    done
}

function install_i3 {
	echo
	echo "Dependencies: I3-gaps, I3blocks, dmenu, feh"
	read -p "Do you want to setup I3?  (y/n): " i3_answer

	case $i3_answer in 
		[yY])
			echo
			make_dir $HOME/.config/i3
			link_resource "i3-config.sh" "$HOME/.config/i3/config"
			make_dir "$HOME/.config/i3blocks"

			echo
			echo "Linking i3blocks tree (recursively) to ~/.config/i3blocks"
			link_directory_recursively "i3blocks" "$HOME/.config/i3blocks"

			echo 
			make_dir "$HOME/Pictures/Wallpapers/mountains.jpg"
			link_resource "Wallpapers/mountains.jpg" "$HOME/Pictures/Wallpapers/mountains.jpg"
			;;

		[nN])
			echo "I3 setup skipped."
			;;

		*)
            echo "Invalid input. Zathura setup skipped."
			;;
	esac
}

# Alacritty
prompt_and_link ".alacritty.yml" "$HOME/.alacritty.yml"

# Tmux
prompt_and_link ".tmux.conf" "$HOME/.tmux.conf"

# I3 setup
prompt_and_link ".xinitrc" "$HOME/.xinitrc"
install_i3

# Zathura setup
install_zathura
