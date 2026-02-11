-- TODO: Add looser settings to pyright
-- TODO: Remove LuaSnip as ultisnip is already in use

return {
    "neovim/nvim-lspconfig",

    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "quangnguyen30192/cmp-nvim-ultisnips",
        "nvimtools/none-ls.nvim",
        "dcampos/cmp-emmet-vim"
    },

    config = function()
        -----------------------------------------------------------
        -- Setup imports
        -----------------------------------------------------------
        local lspconfig = require("lspconfig")
        local cmp = require("cmp")
        local cmp_lsp = require("cmp_nvim_lsp")

        -----------------------------------------------------------
        -- Global diagnostic configuration
        -----------------------------------------------------------
        vim.diagnostic.config({
            virtual_text = {
                prefix = '●',  -- Could be '■', '▶', '▎', '●'
                spacing = 2,
            },
            signs = true,
            underline = true,
            update_in_insert = true,
            severity_sort = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })

        -----------------------------------------------------------
        -- LSP capabilities (for nvim-cmp integration)
        -----------------------------------------------------------
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities()
        )

        -----------------------------------------------------------
        -- Mason and mason-lspconfig setup
        -----------------------------------------------------------
        require("mason").setup()

        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "pyright",
                "texlab",
                "clangd"
            },

            handlers = {
                -- Default handler
                function(server_name)
                    if server_name == "tsserver" then
                        server_name = "ts_ls"
                    end
                    lspconfig[server_name].setup({
                        capabilities = capabilities,
                    })
                end,

                -------------------------------------------------------
                -- Custom LSP setups
                -------------------------------------------------------

                -- Pyright
                ["pyright"] = function()
                    lspconfig.pyright.setup({
                        capabilities = capabilities,
                        filetypes = {"python"},
                        settings = {
                            python = {
                                analysis = {
                                    typeCheckingMode = "basic", -- or "off", "basic", "strict"
                                    autoSearchPaths = true,
                                    useLibraryCodeForTypes = true,
                                },
                            },
                        },
                    })
                end,

                -- Lua LSP
                ["lua_ls"] = function()
                    lspconfig.lua_ls.setup({
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = { version = "Lua 5.1" },
                                diagnostics = {
                                    globals = {
                                        "bit", "vim", "it", "describe",
                                        "before_each", "after_each"
                                    },
                                },
                            },
                        },
                    })
                end,
            },
        })

        -----------------------------------------------------------
        -- Completion (nvim-cmp) setup
        -----------------------------------------------------------
        cmp.setup({
            snippet = {
                expand = function(args)
                    vim.fn["UltiSnips#Anon"](args.body)
                end,
            },

            mapping = {
                -- Confirm with Enter
                ['<CR>'] = cmp.mapping.confirm({ select = true }),

                -- Navigate completions
                ['<C-j>']   = cmp.mapping.select_next_item(),
                ['<C-k>'] = cmp.mapping.select_prev_item(),

                -- Jump **forwards** (UltiSnips only, avoids scrolling the list)
                -- ['<C-j>'] = function(fallback)
                --     if vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
                --         vim.fn["UltiSnips#JumpForwards"]()
                --     else
                --         fallback()
                --     end
                -- end,
                --
                -- -- Jump **backwards** (UltiSnips only, avoids scrolling the list)
                -- ['<C-k>'] = function(fallback)
                --     if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
                --         vim.fn["UltiSnips#JumpBackwards"]()
                --     else
                --         fallback()
                --     end
                -- end,
            },

            sources = cmp.config.sources(
                {
                    { name = "nvim_lsp" },
                    { name = "ultisnips" },
                    { name = "emmet_vim" },
                },
                {
                    { name = "buffer" },
                }
            )
        })

        -----------------------------------------------------------
        -- Keybindings
        -----------------------------------------------------------
        local map = vim.api.nvim_set_keymap
        local opts = { noremap = true, silent = true }
        map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
        map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
        map('n', 'dg', '<cmd>nohlsearch<CR>', opts)  -- Fixed incomplete command

    end
}
