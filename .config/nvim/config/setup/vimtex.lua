vim.g.vimtex_compiler_latexmk = {
    aux_dir = './misc',
}


vim.g.vimtex_compiler_method = 'latexmk'
vim.g.tex_flavor = 'latex'

vim.g.vimtex_view_method = 'zathura'


vim.g.vimtex_compiler_latexmk_engines = {
    pdflatex = '-pdflatex=pdflatex',
}

vim.api.nvim_command('set conceallevel=1')
vim.g.tex_conceal = 'abdmg'

vim.api.nvim_exec([[
  let g:vimtex_auto_write = 0
]], false)

-- Set spellcheck language to Swedish and English when opening TeX file
vim.api.nvim_exec([[
    augroup SetSpellLang
        autocmd!
        autocmd FileType tex setlocal spelllang=sv,en
    augroup END
]], false)

