#!/usr/bin/env bash

# --- Configuration ---
DOTFILES="$HOME/.dotfiles"
STOW_FOLDERS="nvim,tmux,zsh,zathura,alacritty,lazygit,systemd"
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

    if ! command -v rg &> /dev/null; then
        log_info "ripgrep not found. Installing..."
        sudo apt install -y ripgrep &>/dev/null
        log_success "ripgrep installed successfully."
    else
        log_success "ripgrep is already installed."
    fi

    if ! command -v fd &> /dev/null && ! command -v fdfind &> /dev/null; then
        log_info "fd not found. Installing..."
        sudo apt install -y fd-find &>/dev/null
        # Ubuntu/Debian installs fd as fdfind — symlink to fd
        sudo ln -sf "$(which fdfind)" /usr/local/bin/fd
        log_success "fd installed successfully."
    else
        log_success "fd is already installed."
    fi

    if ! command -v xclip &> /dev/null; then
        log_info "xclip not found. Installing..."
        sudo apt install -y xclip &>/dev/null
        log_success "xclip installed successfully."
    else
        log_success "xclip is already installed."
    fi

    if ! fc-list | grep -qi "JetBrainsMono"; then
        log_warn "JetBrains Mono Nerd Font not detected! Icons may look like boxes."
    fi
}

install_neovim() {

    if ! command -v nvim &> /dev/null; then
        header "Installing Neovim v0.11.6 (Stable)"
        NVIM_VERSION="v0.11.6"
        log_info "Downloading Neovim $NVIM_VERSION..."
        curl -L -o /tmp/nvim-linux-x86_64.appimage "https://github.com/neovim/neovim/releases/download/$NVIM_VERSION/nvim-linux-x86_64.appimage"
        chmod +x /tmp/nvim-linux-x86_64.appimage
        sudo mv /tmp/nvim-linux-x86_64.appimage /usr/local/bin/nvim
        log_success "Neovim $NVIM_VERSION installed to /usr/local/bin/nvim"
    fi
}

install_rust() {
    # shellcheck disable=SC1091
    [ -s "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

    if command -v rustup &> /dev/null; then
        log_info "Updating Rust to latest stable..."
        rustup update stable &>/dev/null
        log_success "Rust is already installed: $(cargo --version)"
        return
    fi

    header "Installing Rust (via rustup)"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
    # shellcheck disable=SC1091
    source "$HOME/.cargo/env"
    log_success "Rust installed: $(cargo --version)"
}

install_alacritty() {
    if command -v alacritty &> /dev/null; then
        log_success "Alacritty is already installed: $(alacritty --version)"
        return
    fi

    header "Installing Alacritty (from source)"

    # Build dependencies
    log_info "Installing Alacritty build dependencies..."
    sudo apt install -y cmake pkg-config libfreetype6-dev libfontconfig1-dev \
        libxcb-xfixes0-dev libxkbcommon-dev python3 &>/dev/null

    # Load cargo if not in PATH yet
    # shellcheck disable=SC1091
    [ -s "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

    log_info "Ensuring Rust is up to date (edition2024 requires 1.85+)..."
    # shellcheck disable=SC1091
    [ -s "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"
    rustup update stable

    log_info "Cloning Alacritty repository..."
    rm -rf /tmp/alacritty-src
    git clone --depth=1 https://github.com/alacritty/alacritty.git /tmp/alacritty-src

    log_info "Building Alacritty (this may take a few minutes)..."
    if ! cargo build --release -q --manifest-path /tmp/alacritty-src/Cargo.toml; then
        log_error "Alacritty build failed."
        rm -rf /tmp/alacritty-src
        return 1
    fi

    log_info "Installing Alacritty binary..."
    sudo cp /tmp/alacritty-src/target/release/alacritty /usr/local/bin/alacritty

    log_info "Installing desktop entry and icon..."
    sudo cp /tmp/alacritty-src/extra/linux/Alacritty.desktop /usr/share/applications/
    sudo cp /tmp/alacritty-src/extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
    sudo update-desktop-database /usr/share/applications/ 2>/dev/null

    rm -rf /tmp/alacritty-src
    log_success "Alacritty installed: $(alacritty --version)"
}

install_jetbrains_mono_nerd_font() {
    if fc-list | grep -qi "JetBrainsMono"; then
        log_success "JetBrains Mono Nerd Font is already installed."
        return
    fi

    header "Installing JetBrains Mono Nerd Font"
    FONT_VERSION="v3.3.0"
    FONT_DIR="$HOME/.local/share/fonts/JetBrainsMono"
    mkdir -p "$FONT_DIR"

    log_info "Downloading JetBrains Mono Nerd Font $FONT_VERSION..."
    curl -L -o /tmp/JetBrainsMono.zip \
        "https://github.com/ryanoasis/nerd-fonts/releases/download/$FONT_VERSION/JetBrainsMono.zip"

    unzip -o /tmp/JetBrainsMono.zip -d "$FONT_DIR" '*.ttf' &>/dev/null
    rm /tmp/JetBrainsMono.zip

    fc-cache -fv "$FONT_DIR" &>/dev/null
    log_success "JetBrains Mono Nerd Font installed."
}

install_nvm_node() {
    NVM_VERSION="v0.40.3"
    NODE_VERSION="22"
    export NVM_DIR="$HOME/.config/nvm"

    if [ ! -d "$NVM_DIR" ]; then
        mkdir -p "$NVM_DIR"
    fi

    if [ ! -s "$NVM_DIR/nvm.sh" ]; then
        header "Installing NVM $NVM_VERSION"
        curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh" | bash
        log_success "NVM $NVM_VERSION installed."
    else
        log_success "NVM is already installed."
    fi

    # Load nvm in current shell so we can use it immediately
    # shellcheck disable=SC1091
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

    if ! nvm ls "$NODE_VERSION" &>/dev/null; then
        header "Installing Node.js $NODE_VERSION LTS (via NVM)"
        nvm install "$NODE_VERSION"
        nvm alias default "$NODE_VERSION"
        log_success "Node.js $NODE_VERSION installed and set as default."
    else
        log_success "Node.js $NODE_VERSION is already installed."
    fi

    if ! npm list -g neovim &>/dev/null; then
        log_info "Installing neovim npm package..."
        npm install -g neovim &>/dev/null
        log_success "neovim npm package installed."
    else
        log_success "neovim npm package already installed."
    fi

    if ! command -v tree-sitter &>/dev/null; then
        log_info "Installing tree-sitter-cli (via cargo)..."
        sudo apt install -y libclang-dev &>/dev/null
        # shellcheck disable=SC1091
        [ -s "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"
        if cargo install tree-sitter-cli -q; then
            log_success "tree-sitter-cli installed."
        else
            log_error "tree-sitter-cli installation failed."
        fi
    else
        log_success "tree-sitter-cli already installed."
    fi
}

install_ruff() {
    if command -v ruff &> /dev/null; then
        log_success "ruff is already installed: $(ruff --version)"
        return
    fi

    header "Installing ruff"
    curl -LsSf https://astral.sh/ruff/install.sh | sh
    log_success "ruff installed: $(ruff --version)"
}

install_lazygit() {
    if command -v lazygit &> /dev/null; then
        log_success "lazygit is already installed: $(lazygit --version | head -1)"
        return
    fi

    header "Installing lazygit"
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep '"tag_name"' | sed 's/.*"v\([^"]*\)".*/\1/')
    curl -Lo /tmp/lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar -xf /tmp/lazygit.tar.gz -C /tmp lazygit
    sudo install /tmp/lazygit /usr/local/bin/lazygit
    rm /tmp/lazygit.tar.gz /tmp/lazygit
    log_success "lazygit installed: $(lazygit --version | head -1)"
}

install_golang() {
    if ! command -v go &> /dev/null; then
        header "Installing Go v1.24.0 (Stable)"
        GO_VERSION="1.24.0"
        GO_ARCHIVE="go$GO_VERSION.linux-amd64.tar.gz"

        log_info "Downloading Go $GO_VERSION..."

        # Download
        curl -L -o /tmp/"$GO_ARCHIVE" "https://go.dev/dl/$GO_ARCHIVE"
        log_info "Extracting Go to /usr/local..."
        rm -rf /usr/local/go
        sudo tar -C /usr/local -xzf /tmp/"$GO_ARCHIVE"

        log_info "Creating symbolic link..."
        sudo ln -sf /usr/local/go/bin/go /usr/local/bin/go

        rm /tmp/"$GO_ARCHIVE"
        log_success "Go $GO_VERSION installed successfully."
    else
        log_info "Go is already installed: $(go version)"
    fi
}


# --- Main Execution ---

# Ensure we are in the right place
cd "$DOTFILES" || { log_error "Could not find $DOTFILES"; exit 1; }

install_dependencies
install_rust
install_jetbrains_mono_nerd_font
install_neovim
install_nvm_node
install_alacritty
install_ruff
install_lazygit
install_golang

header "Stowing Configurations"

IFS=',' read -ra folders <<< "$STOW_FOLDERS"

for folder in "${folders[@]}"; do
    if [ -d "$folder" ]; then
        
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
