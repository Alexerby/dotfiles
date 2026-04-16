return {
    "lervag/vimtex",
    lazy = false, -- we don't want to lazy load VimTeX
    -- tag = "v2.15",
    init = function()
        vim.g.vimtex_compiler_latexmk_engines = {
            _ = "-pdflatex"
        }
        vim.g.vimtex_compiler_method = "latexmk"
        vim.g.vimtex_view_method = "zathura"
        vim.g.vimtex_view_general_viewer = 'zathura'
        vim.g.vimtex_quickfix_open_on_warning = 0
    end,

    keys = {
        {
            "<leader>li",
            "<cmd>VimtexTocToggle<cr>",
            desc = "Vimtex TOC",
        },
    }
}
