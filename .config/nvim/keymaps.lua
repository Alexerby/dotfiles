local vim = vim or {} -- Avoid undefined global 'vim' error

local keymap = vim.api.nvim_set_keymap


local opts = { noremap = true, silent = true }


-- :so alias for :source
vim.cmd[[command! -nargs=* So source <args>]]


-- Escape insert mode using j
keymap('i', 'jj', '<Esc>', { noremap = true })


-- Map the key combination to the defined function
keymap('n', '<S-q>', '<Esc>[s1z=A', opts)
keymap('i', '<S-q>', '<Esc>[s1z=A', opts)

-- ToggleTerminal
keymap('n', '<leader>t', ':ToggleTerm<CR>', opts)
keymap('t', '<leader>t', '<C-\\><C-n><cmd>ToggleTerm<CR>', opts)

-- Go to module by "gm" in normal mode
keymap('n', 'gm', '<C-]>', opts)

-- Compile C program with debugging symbols
vim.api.nvim_set_keymap('n', '<F5>', ':!gcc -o %:r -g %<CR>', { silent = true })

-- Run gdb with the compiled program
vim.api.nvim_set_keymap('n', '<F6>', ':!gdb ./%:r<CR>', { silent = true })

