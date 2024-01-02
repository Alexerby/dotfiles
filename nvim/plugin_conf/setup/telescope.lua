local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

require('telescope').setup{
  defaults = {
    file_ignore_patterns = {
      "node_modules/",
      "build/",
	  "__pycache__/",
      "virtualenv/",
      ".*language%-servers/.*",
      -- LaTeX
      "%.aux$",
      "%.bbl$",
      "%.blg$",
      "%.log$",
      "%.synctex.gz$",
      "%.toc$",
      "%.fls$",
      "%.fdb_latexmk$",
      "%.gz$",
      "%.pdf$",
      "%.out$",
      "%.bcf$",
      "%.run.xml$",
    },
  }
}

