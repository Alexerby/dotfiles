return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",

    dependencies = {
        "nvim-lua/plenary.nvim",
    },

    config = function()
        local function get_telescope_ignore_patterns()
            return {
                "node_modules",
                "venv",
                ".git",
                "%.o",
                "%.so",
                "%.a",
                "%.pyc",
                "%.DS_Store",
            }
        end

        local telescope = require("telescope")
        local builtin = require("telescope.builtin")

        telescope.setup({
            defaults = {
                file_ignore_patterns = get_telescope_ignore_patterns(),
            },
            pickers = {},
        })

        local keymap = vim.keymap.set
        local opts = { noremap = true, silent = true }

        keymap('n', '<leader>fg', builtin.live_grep, opts)
        keymap('n', '<leader>fs', builtin.grep_string, opts)
        keymap('n', '<leader>fb', builtin.buffers, opts)
        keymap('n', '<leader>fh', builtin.help_tags, opts)
        keymap('n', '<leader>fr', builtin.lsp_references, opts)

        -- Symbol Searching
        keymap('n', '<leader>ds', builtin.lsp_document_symbols, opts)

        keymap('n', '<leader>ffh', function()
            builtin.find_files({ hidden = true })
        end, opts)

        keymap('n', '<leader>ff', builtin.find_files, opts)
    end,
}
