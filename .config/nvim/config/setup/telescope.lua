local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fs', builtin.grep_string, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})


-- Telescope fuzzy finder without hidden files
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})

-- Telescope fuzzy finder with hidden files
vim.api.nvim_set_keymap('n', '<leader>ffh', '<cmd>lua require("telescope.builtin").find_files({hidden = true})<cr>', {noremap = true, silent = true})


require('telescope').setup{
  defaults = {
    file_ignore_patterns = {
      "node_modules/",
      "build/",
	  "__pycache__",
      "virtualenv",
	  "venv",
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
	hidden = true
  }
}

