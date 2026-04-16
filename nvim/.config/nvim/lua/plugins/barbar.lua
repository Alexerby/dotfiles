return {
    {
        'romgrk/barbar.nvim',
        dependencies = {
            'lewis6991/gitsigns.nvim',
            'nvim-tree/nvim-web-devicons',
        },
        version = '^1.0.0',
        config = function()
            local map = vim.api.nvim_set_keymap
            local opts = { noremap = true, silent = true }

            -- Sort buffers
            map('n', '<leader>bb', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
            map('n', '<leader>bn', '<Cmd>BufferOrderByName<CR>', opts)
            map('n', '<leader>bd', '<Cmd>BufferOrderByDirectory<CR>', opts)
            map('n', '<leader>bl', '<Cmd>BufferOrderByLanguage<CR>', opts)
            map('n', '<leader>bw', '<Cmd>BufferOrderByWindowNumber<CR>', opts)

            -- Pin / Unpin
            map('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)

            -- -- Close buffer
            -- map('n', '<A-c>', '<Cmd>BufferClose<CR>', opts)
            -- Switch to previous buffer (:bp), then delete the alternate buffer (:bd #)
            map('n', '<A-c>', ':bp|bd #<CR>', opts)


            -- Go to specific buffer
            for i = 1, 9 do
                map('n', '<A-' .. i .. '>', '<Cmd>BufferGoto ' .. i .. '<CR>', opts)
            end

            map('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)

            -- Navigation
            map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
            map('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)

            -- Reordering
            map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', opts)
            map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', opts)

        end,
    },
}

