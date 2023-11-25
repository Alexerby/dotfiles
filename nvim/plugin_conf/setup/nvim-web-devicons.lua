require'nvim-web-devicons'.setup {
  override = {
    zsh = {
      icon = "",
      color = "#428850",
      cterm = "italic",
      name = "Zsh"
    }
  },
  color_icons = true,
  default = true,
  strict = true,
  override_by_filename = {
    [".gitignore"] = {
      icon = "",
      color = "#f1502f",
      name = "Gitignore"
    }
  },
  override_by_extension = {
    ["log"] = {
      icon = "",
      color = "#81e043",
      name = "Log"
    }
  }
}


require("nvim-web-devicons").get_icon_by_filetype(filetype, opts)
require("nvim-web-devicons").get_icon_colors_by_filetype(filetype, opts)
require("nvim-web-devicons").get_icon_color_by_filetype(filetype, opts)
require("nvim-web-devicons").get_icon_cterm_color_by_filetype(filetype, opts)

-- Enable NERDTree with icons
vim.g.NERDTreeIndicatorMapCustom = {
  Modified  = "✹",
  Staged    = "✚",
  Untracked = "✭",
  Renamed   = "➜",
  Unmerged  = "═",
  Deleted   = "✖",
  Dirty     = "✗",
  Clean     = "✔︎",
  Ignored   = '☒',
  Unknown   = "★",
}
vim.g.NERDTreeGitStatusIndicatorMapCustom = {
  Modified  = "✹",
  Staged    = "✚",
  Untracked = "✭",
  Renamed   = "➜",
  Unmerged  = "═",
  Deleted   = "✖",
  Dirty     = "✗",
  Clean     = "✔︎",
  Ignored   = '☒',
  Unknown   = "★",
}

