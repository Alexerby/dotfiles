# Neovim Configuration

A modular Neovim setup using [lazy.nvim](https://github.com/folke/lazy.nvim).

## 🚀 Features

- **Plugin Manager**: [lazy.nvim](https://github.com/folke/lazy.nvim)
- **LSP**: [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- **Tree-sitter**: [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- **Telescope**: [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
- **File Explorer**: [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)
- **Statusline**: [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)
- **Tabline**: [barbar.nvim](https://github.com/romgrk/barbar.nvim)
- **Git Integration**: [vim-fugitive](https://github.com/tpope/vim-fugitive) & [lazygit.nvim](https://github.com/kdheepak/lazygit.nvim)
- **Note-taking**: [obsidian.nvim](https://github.com/epwalsh/obsidian.nvim)
- **Productivity**: [harpoon](https://github.com/ThePrimeagen/harpoon), [todo-comments.nvim](https://github.com/folke/todo-comments.nvim), [zen-mode.nvim](https://github.com/folke/zen-mode.nvim)

## 🛠️ Troubleshooting

### Markdown Preview
If `:MarkdownPreview` does not work:
1. Navigate to the plugin directory:
   ```bash
   cd ~/.local/share/nvim/lazy/markdown-preview.nvim
   ```
2. Install dependencies:
   ```bash
   npm install
   ```
3. Run `:checkhealth` in Neovim to verify the installation.

## 📝 TODO

- [ ] Auto-install `typescript-language-server` and `typescript` via `npm`.
- [ ] Refine snippet collection in `lua/snippets/`.

## ⚙️ Environment
- **Neovim Version**: v0.12.0-dev (or newer)
- **LuaJIT**: 2.1
