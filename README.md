# .dotfiles

This repository contains my personal configuration for Neovim, Alacritty, Zsh, and more.

## Neovim Configuration (v0.11.6 Stable)

The current Neovim configuration is designed for **Neovim v0.11.6+**. It uses the modern native LSP APIs (`vim.lsp.config` and `vim.lsp.enable`) to ensure a silent, warning-free, and high-performance experience.

### Pre-requisites
- **Neovim v0.11.6 (Stable)** or newer.
- **GNU Stow** (to symlink files into `~/.config`).
- **Node.js & NPM** (for `ts_ls`).
- **Python & Mason** (for `pyright`, `ruff`).
- **Clang** (for `clangd`).

### How to Apply (Using Stow)

To symlink the configuration to your home directory, run the following from the root of this repository:

```bash
# This will symlink the nvim/ directory into ~/.config/nvim
stow nvim
```

If you need to force a restow (e.g., after manual changes):
```bash
stow -R nvim
```

### Key Features
- **Silent & Stable**: Explicitly filters out deprecation warnings.
- **Auto-LSP**: `ts_ls`, `pyright`, `clangd`, `ruff`, and `lua_ls` attach automatically.
- **Mason Integration**: Pre-pends Mason-s binary path to Neovim-s `PATH` to ensure server discovery.

### LSP Keybindings
- `gd`: Go to definition
- `gr`: References
- `K`: Hover information
- `<leader>rn`: Rename symbol
- `<leader>ca`: Code actions
