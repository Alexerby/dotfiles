#!/usr/bin/env bash

# --- Configuration ---
DOTFILES="$HOME/.dotfiles"
STOW_FOLDERS="nvim,tmux,zsh,zathura,alacritty,lazygit"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"

# --- Colors for better stdout ---
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# --- Helper Functions ---
log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

header() {
    echo -e "\n${BLUE}========================================"
    echo -e "  $1"
    echo -e "========================================${NC}"
}

install_dependencies() {
    header "Checking Dependencies"

    if ! command -v eza &> /dev/null; then
        log_info "eza not found. Setting up Gierens repository..."
        
        sudo apt update && sudo apt install -y gpg wget &>/dev/null
        
        sudo mkdir -p /etc/apt/keyrings
        wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | \
            sudo gpg --dearmor --yes -o /etc/apt/keyrings/gierens.gpg
        
        echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | \
            sudo tee /etc/apt/sources.list.d/gierens.list >/dev/null
        
        sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
        sudo apt update &>/dev/null
        sudo apt install -y eza &>/dev/null
        
        log_success "eza installed successfully."
    else
        log_success "eza is already installed."
    fi

    if ! fc-list | grep -qi "nerd"; then
        log_warn "No Nerd Font detected! Icons will look like boxes."
    fi
}

# --- Main Execution ---

# Ensure we are in the right place
cd "$DOTFILES" || { log_error "Could not find $DOTFILES"; exit 1; }

install_dependencies

header "Stowing Configurations"

IFS=',' read -ra folders <<< "$STOW_FOLDERS"

for folder in "${folders[@]}"; do
    if [ -d "$folder" ]; then
        log_info "Processing: $folder"
        
        # 1. Attempt to unstow first (clean up old links)
        stow -D -d "$DOTFILES" -t "$HOME" "$folder" 2>/dev/null
        
        # 2. Try to stow
        # We capture the output to check for "conflicts"
        STOW_OUTPUT=$(stow -v -d "$DOTFILES" -t "$HOME" "$folder" 2>&1)
        
        if [[ $STOW_OUTPUT == *"conflict"* ]]; then
            log_warn "Conflict detected in '$folder'. Moving existing files to $BACKUP_DIR"
            mkdir -p "$BACKUP_DIR"
            
            # Extract the filename from the error message and move it
            # This is a simple way to clear the path for Stow
            ERR_FILE=$(echo "$STOW_OUTPUT" | grep "existing target" | awk '{print $NF}')
            if [ -n "$ERR_FILE" ]; then
                mv "$HOME/$ERR_FILE" "$BACKUP_DIR/" 2>/dev/null
                # Try stowing again after backup
                stow -d "$DOTFILES" -t "$HOME" "$folder"
                log_success "$folder stowed after backup."
            fi
        else
            log_success "$folder stowed."
        fi
    else
        log_error "Folder '$folder' does not exist in $DOTFILES"
    fi
done

header "Installation Complete"
echo -e "${GREEN}All systems go! Restart your terminal to see changes.${NC}\n"
