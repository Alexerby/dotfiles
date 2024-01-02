require("nightly").setup({
  transparent = true,
  styles = {
    comments = { italic = true, fg = "#1ECBE1" },
    functions = { italic = false },
    variables = { italic = true, fg = "#FFA07A" },  -- Highlight variables in italic with a specific color
    keywords = { italic = false },
  },
  highlights = {},
})

vim.cmd([[colorscheme nightly]])
vim.api.nvim_exec([[
  augroup CustomVisualHighlight
    autocmd!
    autocmd ColorScheme * highlight Visual guibg=#808080 ctermbg=none
  augroup END
]], false)
