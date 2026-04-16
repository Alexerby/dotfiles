return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
        formatters_by_ft = {
            tex = { "latexindent" },
        },
        format_on_save = function(bufnr)
            local bufname = vim.api.nvim_buf_get_name(bufnr)
            if bufname:match("%.cpp$") or bufname:match("%.hpp$") then
                return
            end
            return {
                timeout_ms = 500,
                lsp_fallback = true,
            }
        end,
    },
}
