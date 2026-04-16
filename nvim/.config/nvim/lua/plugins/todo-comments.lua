return {
  "folke/todo-comments.nvim",

  dependencies = {
    "nvim-lua/plenary.nvim",
  },

  opts = {
    -----------------------------------------------------------
    -- General settings
    -----------------------------------------------------------
    signs = true,             -- show icons in the signs column
    sign_priority = 8,        -- sign priority

    -----------------------------------------------------------
    -- Keywords recognized as todo comments
    -----------------------------------------------------------
    keywords = {
      FIX = {
        icon = " ",           -- icon for signs and search results
        color = "error",       -- color name or hex
        alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- aliases for FIX
        -- signs = false,     -- configure signs per keyword (optional)
      },
      TODO = { icon = " ", color = "info" },
      HACK = { icon = " ", color = "warning" },
      WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
      PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
      NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
      TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
    },

    -----------------------------------------------------------
    -- GUI style for highlights
    -----------------------------------------------------------
    gui_style = {
      fg = "NONE",            -- foreground style for highlight group
      bg = "BOLD",            -- background style for highlight group
    },

    merge_keywords = true,    -- merge custom keywords with defaults

    -----------------------------------------------------------
    -- Highlighting options
    -----------------------------------------------------------
    highlight = {
      multiline = true,                   -- enable multiline todo comments
      multiline_pattern = "^.",           -- lua pattern for next multiline line
      multiline_context = 10,             -- lines re-evaluated on line change

      before = "",                        -- highlight before keyword (fg, bg or empty)
      keyword = "wide",                   -- highlight style for keyword (fg, bg, wide, wide_bg, wide_fg, or empty)
      after = "fg",                      -- highlight after keyword (fg, bg or empty)

      pattern = [[.*<(KEYWORDS)\s*:]],   -- vim regex pattern for matching keywords
      comments_only = true,               -- match keywords only in comments (via treesitter)

      max_line_len = 400,                 -- ignore lines longer than this
      exclude = {},                      -- filetypes to exclude from highlighting
    },

    -----------------------------------------------------------
    -- Color definitions
    -----------------------------------------------------------
    colors = {
      error   = { "DiagnosticError", "ErrorMsg", "#DC2626" },
      warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
      info    = { "DiagnosticInfo", "#2563EB" },
      hint    = { "DiagnosticHint", "#10B981" },
      default = { "Identifier", "#7C3AED" },
      test    = { "Identifier", "#FF00FF" },
    },

    -----------------------------------------------------------
    -- Search settings (uses ripgrep)
    -----------------------------------------------------------
    search = {
      command = "rg",
      args = {
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
      },

      -- regex used for matching keywords (do NOT remove the (KEYWORDS) placeholder)
      pattern = [[\b(KEYWORDS):]],     -- ripgrep regex
      -- pattern = [[\b(KEYWORDS)\b]], -- alternative: match without colon (may cause false positives)
    },
  },
}
