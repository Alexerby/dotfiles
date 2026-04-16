return {
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = "cd app && yarn install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    },

    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
        opts = {
            latex = {
                enabled = true,
                render_modes = false,
                converter = { 'utftex', 'latex2text' },
                highlight = 'RenderMarkdownMath',
                position = 'center',
                top_pad = 0,
                bottom_pad = 0,
            },
        },
    }
}
