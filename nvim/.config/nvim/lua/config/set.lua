-----------------------------------------------------------
-- General Options
-----------------------------------------------------------
vim.opt.guicursor = ""
vim.opt.clipboard = "unnamedplus"
vim.opt.conceallevel = 1

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


-- Markdown Word Wrap
local markdown_group = vim.api.nvim_create_augroup("MarkdownWrap", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    group = markdown_group,
    pattern = {"markdown"},
    callback = function()
        -- Visual wrapping without breaking words
        vim.wo.wrap = true
        vim.wo.linebreak = true
        vim.wo.showbreak = "↪ "

        -- Optional: automatic hard wrapping at 80 characters
        vim.bo.textwidth = 80
        vim.bo.formatoptions = vim.bo.formatoptions .. "t"
    end,
})
