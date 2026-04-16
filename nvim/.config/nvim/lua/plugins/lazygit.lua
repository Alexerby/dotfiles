return {
    "kdheepak/lazygit.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },

    cmd = { "LazyGit" },

    keys = {
        { "<leader>lg", "<cmd>LazyGit<cr>", desc = "Open Lazy Git" },
    },
}
