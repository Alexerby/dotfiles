return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
    },

    config = function()
        -- SILENCE DEPRECATION WARNINGS
        local original_notify = vim.notify
        vim.notify = function(msg, level, opts)
            if type(msg) == "string" and (msg:find("deprecated") or msg:find("removed in nvim-lspconfig v3.0.0")) then
                return
            end
            original_notify(msg, level, opts)
        end

        local cmp = require("cmp")
        local cmp_lsp = require("cmp_nvim_lsp")
        local lspconfig = require("lspconfig")

        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities()
        )

        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = { "ts_ls", "pyright", "clangd", "lua_ls", "ruff" },
        })

        -- Setup Helper for 0.11+ Native LSP
        local function setup_server(name, opts)
            opts = opts or {}
            opts.capabilities = capabilities
            -- We call config THEN enable to ensure settings are applied
            vim.lsp.config(name, opts)
            vim.lsp.enable(name)
        end

        -- TypeScript (ts_ls)
        -- Removing custom root_dir to let default nvim-lspconfig logic (which includes single_file_support) work
        setup_server("ts_ls", {
            single_file_support = true,
            -- Explicitly list filetypes to ensure attachment
            filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
        })

        -- Python
        setup_server("pyright", {
            settings = { 
                python = { 
                    analysis = { 
                        typeCheckingMode = "basic",
                        autoSearchPaths = true,
                        useLibraryCodeForTypes = true
                    } 
                } 
            }
        })

        -- C/C++
        setup_server("clangd")

        -- Lua
        setup_server("lua_ls", {
            settings = { Lua = { diagnostics = { globals = { "vim" } } } }
        })

        -- Ruff (Python Linting)
        setup_server("ruff")

        -- Completion
        cmp.setup({
            snippet = { expand = function(args) vim.fn["UltiSnips#Anon"](args.body) end },
            mapping = cmp.mapping.preset.insert({
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
            }),
            sources = cmp.config.sources({ { name = "nvim_lsp" } }, { { name = "buffer" } }),
        })

        -- Global Keymaps
        local map_opts = { noremap = true, silent = true }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, map_opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, map_opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, map_opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, map_opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, map_opts)
    end,
}