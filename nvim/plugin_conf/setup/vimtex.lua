vim.api.nvim_set_var('mapleader', ',')
vim.cmd('filetype plugin indent on')
vim.cmd('syntax enable')

vim.g.vimtex_view_general_viewer = 'evince'
vim.g.vimtex_compiler_method = 'pdflatex'

vim.g.maplocalleader = ','

vim.api.nvim_set_keymap('n', '<leader>tc', ':VimtexTocToggle<CR>', { noremap = true, silent = true })


vim.api.nvim_set_keymap('n', '<leader>t', [[
    :call append(line('.'), "\\begin{table}")<CR>
    :normal! o\end{table}<Esc>
]], { noremap = true, silent = true })

