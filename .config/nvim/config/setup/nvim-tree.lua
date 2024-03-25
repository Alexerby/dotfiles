
require'nvim-tree'.setup({
    filters = {
        dotfiles = false,
    }
})


vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.g.nvim_tree_disable_window_picker = 1
