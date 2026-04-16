return {
    "folke/trouble.nvim",
    cmd = "Trouble",
    keys = {
        {
            "<leader>xx",
            "<cmd>Trouble diagnostics toggle win.size=0.20<cr>",
            desc = "Diagnostics (Trouble)",
        },
        {
            "<leader>xX",
            "<cmd>Trouble diagnostics toggle filter.buf=0 win.size=0.20<cr>",
            desc = "Buffer Diagnostics (Trouble)",
        },
        {
            "<leader>cs",
            "<cmd>Trouble symbols toggle focus=false win.size=0.40<cr>",
            desc = "Symbols (Trouble)",
        },
        {
            "<leader>cl",
            "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
            desc = "LSP Definitions / references / ... (Trouble)",
        },
        {
            "<leader>xL",
            "<cmd>Trouble loclist toggle<cr>",
            desc = "Location List (Trouble)",
        },
        {
            "<leader>xQ",
            "<cmd>Trouble qflist toggle<cr>",
            desc = "Quickfix List (Trouble)",
        },
    },
    opts = {},
}
