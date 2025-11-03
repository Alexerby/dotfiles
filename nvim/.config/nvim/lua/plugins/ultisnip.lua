return {
    "SirVer/ultisnips",
    config = function()
        vim.g.UltiSnipsEditSplit = "vertical"
        vim.g.UltiSnipsSnippetDirectories = {'~/.config/nvim/lua/snippets'}

        vim.g.UltiSnipsExpandTrigger="<tab>"
        vim.g.UltiSnipsJumpForwardTrigger="<Tab>"
        vim.g.UltiSnipsJumpBackwardTrigger="<S-Tab>"
    end,
}
