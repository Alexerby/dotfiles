

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

