-- Keymap Helper
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-----------------------------------------------------------
-- General
-----------------------------------------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = " "

map('i', 'jj', '<ESC>', opts)
map('n', '<leader>d', '<Cmd>nohlsearch<CR>', opts)
map('n', '<F4>', ':w<CR>:!python3 %<CR>', opts)
map('n', '<F5>', ':w<CR>:!python3 % &<CR>', opts)
map('n', '<leader>w', '<C-w>', opts)
-- map('n', '<leader>sv', '<Cmd>:source $MYVIMRC<CR>', opts)
map('n', '<leader>sv', '<Cmd>echo "Sourcing nvim file"<CR><Cmd>source %<CR>', opts)
