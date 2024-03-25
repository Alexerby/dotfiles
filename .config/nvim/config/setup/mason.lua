require("mason").setup()

require("mason-lspconfig").setup {
    ensure_installed = { "lua_ls",
	"rust_analyzer",
	"quick_lint_js",
	"pyright",
	"emmet_ls",
	"stylelint_lsp"
	},
}







