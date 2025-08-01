return {
    "SirVer/ultisnips",
    config = function()
        vim.g.UltiSnipsEditSplit = "vertical"
        vim.g.UltiSnipsSnippetDirectories = {'~/.config/nvim/lua/snippets'}

        vim.g.UltiSnipsExpandTrigger="<tab>"
        vim.g.UltiSnipsJumpForwardTrigger="<C-j>"
        vim.g.UltiSnipsJumpBackwardTrigger="<C-k>"
    end,
}


