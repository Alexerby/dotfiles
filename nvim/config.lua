
-- Show line numbers
vim.wo.number = true

-- Show relative line numbers
vim.wo.relativenumber = true

-- Set the background color for line numbers column
vim.cmd('highlight LineNr ctermbg=NONE guibg=NONE')

-- Set the background color for the current line number
vim.cmd('highlight CursorLineNr ctermbg=NONE guibg=NONE')

vim.o.tabstop = 4
vim.o.shiftwidth = 4

