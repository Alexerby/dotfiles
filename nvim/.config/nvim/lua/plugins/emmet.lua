return {
  "mattn/emmet-vim",
  ft = { "html", "css", "scss", "sass", "javascript", "typescript", "javascriptreact", "typescriptreact", "vue", "svelte", "htmldjango" },
  config = function()
    -- Use Lua API to set keymaps in insert and select modes
    local opts = { noremap = false, silent = true, expr = false }
    vim.keymap.set('i', '<C-e>', '<Plug>(emmet-expand-abbr)', opts)
    vim.keymap.set('s', '<C-e>', '<Plug>(emmet-expand-abbr)', opts)
  end,
}
