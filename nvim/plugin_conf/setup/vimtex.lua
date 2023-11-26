vim.api.nvim_set_var('mapleader', ',')

vim.g.vimtex_view_general_viewer = 'evince'
vim.g.vimtex_compiler_method = 'pdflatex'

vim.g.maplocalleader = ','

vim.api.nvim_set_keymap('n', '<leader>tc', ':VimtexTocToggle<CR>', { noremap = true, silent = true })



