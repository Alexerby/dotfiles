return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.5",

  dependencies = {
    "nvim-lua/plenary.nvim",
  },

  config = function()
    -----------------------------------------------------------
    -- Define global ignore patterns for Telescope
    -----------------------------------------------------------
    -- This function returns a table of file patterns that Telescope should ignore.
    -- It can be used to centralize ignore logic for various Telescope pickers.
    local function get_telescope_ignore_patterns()
      return {
        "node_modules", -- Ignore node_modules directories
        "venv",         -- Ignore Python virtual environments
        ".git",         -- Ignore Git-related files/directories
        "%.o",          -- Ignore object files
        "%.so",         -- Ignore shared library files
        "%.a",          -- Ignore static library files
        "%.pyc",        -- Ignore Python compiled files
        "%.DS_Store",   -- Ignore macOS specific files
      }
    end

    -----------------------------------------------------------
    -- Setup telescope
    -----------------------------------------------------------
    local telescope = require("telescope")
    local builtin = require("telescope.builtin")

    -- Configure Telescope with default settings, including global ignore patterns.
    -- These patterns will apply to all pickers that respect 'file_ignore_patterns'.
    telescope.setup({
      defaults = {
        file_ignore_patterns = get_telescope_ignore_patterns(),
        -- You can add more global defaults here if needed
      },
      -- You can add specific picker configurations here
      pickers = {
        -- Example: You can override or add specific patterns for find_files if needed
        -- find_files = {
        --   file_ignore_patterns = { "another_specific_pattern" },
        -- },
      },
    })

    -----------------------------------------------------------
    -- Key mappings
    -----------------------------------------------------------
    local keymap = vim.keymap.set
    local opts = { noremap = true, silent = true } -- Added noremap and silent for better keymap practice

    -- General search commands
    -- These commands will now automatically use the global ignore patterns defined in telescope.setup
    keymap('n', '<leader>fg', builtin.live_grep, opts)       -- Search for a string in your current working directory
    keymap('n', '<leader>fs', builtin.grep_string, opts)    -- Search for the word under your cursor
    keymap('n', '<leader>fb', builtin.buffers, opts)        -- List open buffers
    keymap('n', '<leader>fh', builtin.help_tags, opts)      -- Search Neovim help tags
    keymap('n', '<leader>fr', builtin.lsp_references, opts) -- Find LSP references for the word under cursor

    -- File search (non-filtered) - This will still use global ignore patterns unless explicitly overridden
    keymap('n', '<leader>ffh', function()
      require('telescope.builtin').find_files({ hidden = true })
    end, opts)

    -- File search (using global ignore patterns)
    -- Since 'file_ignore_patterns' is set in telescope.setup.defaults,
    -- this call to find_files will automatically inherit those patterns.
    -- No need to explicitly pass them here unless you want to add *more* patterns
    -- specific to this mapping, or override the global ones.
    keymap('n', '<leader>ff', builtin.find_files, opts)
  end,
}
