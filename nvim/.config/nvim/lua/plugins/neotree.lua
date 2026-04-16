return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
        "antosha417/nvim-lsp-file-operations",
    },

    config = function()
        -- Initialize file operations before neo-tree
        require("lsp-file-operations").setup()

        require("neo-tree").setup({
            filesystem = {
                follow_current_file = {
                    enabled = true,
                },
            },
        })

        -----------------------------------------------------------
        -- Keybindings
        -----------------------------------------------------------
        local map = vim.api.nvim_set_keymap
        local opts = { noremap = true, silent = true }
        map('n', '<leader>e', '<Cmd>Neotree toggle<CR>', opts)
    end,
}
