local vim = vim or {} -- Avoid undefined global 'vim' error

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key


-- :so alias for :source
vim.cmd[[command! -nargs=* So source <args>]]


-- Escape insert mode using j
keymap('i', 'jj', '<Esc>', { noremap = true })


-- Map the key combination to the defined function
keymap('n', '<S-q>', '<Esc>[s1z=A', opts)
keymap('i', '<S-q>', '<Esc>[s1z=A', opts)

-- ToggleTerminal
keymap('n', '<leader>t', ':ToggleTerm<CR>', opts)
keymap('t', '<leader>t', '<C-\\><C-n><cmd>ToggleTerm<CR>', opts)

-- Go to module by "gm" in normal mode
keymap('n', 'gm', '<C-]>', opts)

-- Compile C program with debugging symbols
vim.api.nvim_set_keymap('n', '<F5>', ':!gcc -o %:r -g %<CR>', { silent = true })

-- Run gdb with the compiled program
vim.api.nvim_set_keymap('n', '<F6>', ':!gdb ./%:r<CR>', { silent = true })

vim.keymap.set({"i"}, "<C-K>", function() ls.expand() end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-L>", function() ls.jump( 1) end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-J>", function() ls.jump(-1) end, {silent = true})


vim.api.nvim_set_keymap('n', 'dg', ':nohlsearch<CR>', { noremap = true, silent = true })
