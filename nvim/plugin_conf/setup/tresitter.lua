

local configs = require("nvim-treesitter.configs")
configs.setup {

-- Add a language of your choice
  ensure_installed = {"cpp", "python", "lua", "java", "javascript", "latex"},
  sync_install = false,

  highlight = {
    enable = true, -- false will disable the whole extension

  },
  indent = { enable = true, disable = { "yaml" } },
  rainbow = {
    enable = true,
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
  }
}
