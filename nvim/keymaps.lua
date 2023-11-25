vim.api.nvim_set_keymap('n', '<C-t>', ':NERDTreeToggle<CR>', { noremap = true, silent = true })

-- :so alias for :source
vim.cmd[[command! -nargs=* So source <args>]]

-- :wso alias for :w and :so
vim.cmd[[command! Wso w | so %]]

-- Escape insert mode using jj
vim.api.nvim_set_keymap('i', 'jj', '<Esc>', { noremap = true })

require('keymap.tex')



