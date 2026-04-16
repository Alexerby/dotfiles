-- Keymap Helper
-- local map = vim.api.nvim_set_keymap
local keymap = vim.keymap.set
-- local opts = { noremap = true, silent = true }
local opts = { silent = true }



-----------------------------------------------------------
-- General
-----------------------------------------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = " "

keymap('i', 'jj', '<ESC>', opts)
keymap('n', '<leader>d', '<Cmd>nohlsearch<CR>', opts)
keymap('n', '<F4>', ':w<CR>:!python3 %<CR>', opts)
keymap('n', '<F5>', ':w<CR>:!python3 % &<CR><CR>', opts)
keymap('n', '<leader>w', '<C-w>', opts)
keymap('n', '<leader>sv', '<Cmd>echo "Sourcing nvim file"<CR><Cmd>source %<CR>', opts)
keymap('n', '<leader>n', ':!open .<CR><CR>')


-----------------------------------------------------------
-- MarkdownPreview
-----------------------------------------------------------
vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        local buf_opts = { buffer = true, silent = true, noremap = true }
        vim.keymap.set('n', '<leader>ll', ':MarkdownPreview<CR>', buf_opts)
    end,
})

-----------------------------------------------------------
-- Formatting
-----------------------------------------------------------

vim.keymap.set('n', '<leader>bf', function()
    require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format current buffer (via Conform)" })
