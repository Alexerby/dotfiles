vim = vim or {}

-- Show line numbers
vim.wo.number = true

-- Show relative line numbers
vim.wo.relativenumber = true


vim.api.nvim_exec([[
    set tabstop=4
    set shiftwidth=4
    set expandtab
]], false)

vim.wo.foldenable = false

vim.api.nvim_set_var('mapleader', ',')
vim.g.maplocalleader = ','

-- Set yank, delete, copy, paste to system clipboard
vim.cmd('set clipboard=unnamedplus')




vim.cmd([[
function! PythonAutocmds()
  augroup PythonAutocmds
    autocmd!
    autocmd FileType python nnoremap <buffer> <F4> :w<CR>:!python3 %<CR>
  augroup END
endfunction

call PythonAutocmds()
]])

