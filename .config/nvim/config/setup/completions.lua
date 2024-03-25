
local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then
  return
end

local luasnip_status, luasnip = pcall(require, "luasnip")
if not luasnip_status then
  return
end


require("luasnip/loaders/from_vscode").lazy_load()

vim.opt.completeopt = "menu,menuone,noselect"

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  mapping = cmp.mapping.preset.insert({
    ["<Tab>"] = cmp.mapping.select_next_item(), -- next suggestion
    ["<S-Tab>"] = cmp.mapping.select_prev_item(), -- previous suggestion
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
    ["<C-e>"] = cmp.mapping.abort(), -- close completion window
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
  }),

  -- sources for autocompletion
  sources = cmp.config.sources({
    { name = "nvim_lsp" }, -- LSP
    { name = "luasnip" }, -- snippets
    { name = "buffer" }, -- text within the current buffer
    { name = "path" }, -- file system paths
  }),
})



local lspconfig = require('lspconfig')
lspconfig.pyright.setup {filetypes = { "python" }}
lspconfig.lua_ls.setup{filetypes = { "lua" } }
lspconfig.texlab.setup{filetypes = {"tex"}}
lspconfig.emmet_ls.setup{filetypes = {"html", "htmldjango"}}
lspconfig.clangd.setup{filetypes = {"c", "cpp"}}

lspconfig.cssls.setup {
    filetypes = {"css", "scss", "less"}
}

lspconfig.tsserver.setup {
  filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" }
}
