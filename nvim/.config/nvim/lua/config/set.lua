-----------------------------------------------------------
-- General Options
-----------------------------------------------------------
vim.opt.guicursor = ""
vim.opt.clipboard = "unnamedplus"
vim.opt.conceallevel = 1
vim.opt.fixeol = true

-----------------------------------------------------------
-- Spell Check
-----------------------------------------------------------
vim.opt.spell = true
vim.opt.spelllang = { "en_gb" }

-----------------------------------------------------------
-- UI Settings
-----------------------------------------------------------
vim.o.termguicolors = true
vim.opt.nu = true
vim.opt.relativenumber = true

-----------------------------------------------------------
-- Indentation
-----------------------------------------------------------
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.bo.softtabstop = 4
vim.opt.expandtab = true

-----------------------------------------------------------
-- Folding
-----------------------------------------------------------
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldcolumn = "0"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99 
vim.opt.foldnestmax = 4

function MyFoldText()
  local line = vim.fn.getline(vim.v.foldstart)
  local line_count = vim.v.foldend - vim.v.foldstart + 1
  return " 󰁂 " .. line .. " (" .. line_count .. " lines) "
end

vim.opt.foldtext = "v:lua.MyFoldText()"

-----------------------------------------------------------
-- Autocommands
-----------------------------------------------------------
-- Disable Treesitter highlighting for LaTeX (.tex) files
-- as Vimtex handles it

local tex_group = vim.api.nvim_create_augroup("MyTexAutocmds", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = tex_group,
  pattern = "tex",
  command = "TSDisable highlight",
})


-- Detect global Pynvim python package when working in virtual env
if vim.fn.exists("$VIRTUAL_ENV") == 1 then
    vim.g.python3_host_prog = vim.fn.substitute(vim.fn.system("which -a python3 | head -n2 | tail -n1"), "\n", "", "g")
else
    vim.g.python3_host_prog = vim.fn.substitute(vim.fn.system("which python3"), "\n", "", "g")
end

