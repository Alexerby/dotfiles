local vim = vim or {} -- Avoid undefined global 'vim' error

-- :so alias for :source
vim.cmd[[command! -nargs=* So source <args>]]

-- Escape insert mode using jj
vim.api.nvim_set_keymap('i', 'jj', '<Esc>', { noremap = true })

-- Copy/Cut/Paste selected text from/to Windows clipboard
vim.api.nvim_set_keymap('x', '<C-c>', '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap('x', '<C-x>', '"+d', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<C-w>', '<C-\\><C-n>:CFloatTerm<CR>', {noremap = true, silent = true})

-- Run Python for current file (if cwd set to current dir)
vim.api.nvim_set_keymap('n', '<leader>r', [[:!python3 %<CR>]], { noremap = true, silent = true })

-- ToggleTerminal
vim.api.nvim_set_keymap('n', '<leader>t', ':ToggleTerm<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<leader>t', '<C-\\><C-n><cmd>ToggleTerm<CR>', { noremap = true, silent = true })
