require("mason").setup()
require("mason-lspconfig").setup()

require('lspconfig').lua_ls.setup({
	filetypes = {"lua"}
})

require('lspconfig').texlab.setup({
})


