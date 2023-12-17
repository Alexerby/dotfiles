-- Load Mason and Mason LSPConfig
require("mason").setup()
require("mason-lspconfig").setup()

-- Configure LSP for Lua
require('lspconfig').lua_ls.setup{
  filetypes = {"lua"}
}

-- Configure LSP for Jedi Language Server (Python)
require('lspconfig').jedi_language_server.setup{
  -- Adjust configurations as needed
  filetypes = { 'python' },
}

-- Configure LSP for TexLab
require('lspconfig').texlab.setup{
  -- Your TexLab configuration here
}

