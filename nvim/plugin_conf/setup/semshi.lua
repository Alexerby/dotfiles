local vim = vim or {} -- Avoid undefined global 'vim' error

-- Semshi rename
vim.api.nvim_set_keymap('n', '<silent> <leader>rr', ':lua require"semshi".rename()<CR>', { noremap = true, silent = true })

-- Semshi goto name next/prev
vim.api.nvim_set_keymap('n', '<silent> <Tab>', ':lua require"semshi".goto_next("name")<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<silent> <S-Tab>', ':lua require"semshi".goto_prev("name")<CR>', { noremap = true, silent = true })

-- Semshi goto class next/prev
vim.api.nvim_set_keymap('n', '<silent> <leader>c', ':lua require"semshi".goto_next("class")<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<silent> <leader>C', ':lua require"semshi".goto_prev("class")<CR>', { noremap = true, silent = true })

-- Semshi goto function next/prev
vim.api.nvim_set_keymap('n', '<silent> <leader>f', ':lua require"semshi".goto_next("function")<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<silent> <leader>F', ':lua require"semshi".goto_prev("function")<CR>', { noremap = true, silent = true })

-- Semshi goto unresolved first
vim.api.nvim_set_keymap('n', '<silent> <leader>gu', ':lua require"semshi".goto_first("unresolved")<CR>', { noremap = true, silent = true })

-- Semshi goto parameterUnused first
vim.api.nvim_set_keymap('n', '<silent> <leader>gp', ':lua require"semshi".goto_first("parameterUnused")<CR>', { noremap = true, silent = true })

-- Semshi error
vim.api.nvim_set_keymap('n', '<silent> <leader>ee', ':lua require"semshi".error()<CR>', { noremap = true, silent = true })

-- Semshi goto error
vim.api.nvim_set_keymap('n', '<silent> <leader>ge', ':lua require"semshi".goto_error()<CR>', { noremap = true, silent = true })

