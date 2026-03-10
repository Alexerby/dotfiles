return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
    },

    config = function()
        -- 1. SILENCE THE NOISE: Block those nagging warnings
        local original_notify = vim.notify
        vim.notify = function(msg, ...)
            if msg:find("deprecated") or msg:find("removed in nvim-lspconfig v3.0.0") then
                return
            end
            original_notify(msg, ...)
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

        -- 2. THE NEW 0.11+ WAY (NO WARNINGS):
        -- Instead of server.setup(), we use vim.lsp.enable(server)
        -- nvim-lspconfig handles the config registration automatically in 0.11+
        
        local function enable_server(name, opts)
            opts = opts or {}
            opts.capabilities = capabilities
            -- This applies your custom opts (like settings or root_dir)
            -- without calling the "deprecated framework"
            vim.lsp.config(name, opts)
            vim.lsp.enable(name)
        end

        -- TypeScript
        enable_server("ts_ls", {
            root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git"),
            single_file_support = true
        })

        -- Python
        enable_server("pyright", {
            settings = { python = { analysis = { typeCheckingMode = "basic" } } }
        })

        -- C/C++
        enable_server("clangd")

        -- Lua
        enable_server("lua_ls", {
            settings = { Lua = { diagnostics = { globals = { "vim" } } } }
        })

        -- Completion Setup
        cmp.setup({
            snippet = { expand = function(args) vim.fn["UltiSnips#Anon"](args.body) end },
            mapping = cmp.mapping.preset.insert({
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
            }),
            sources = cmp.config.sources({ { name = "nvim_lsp" } }, { { name = "buffer" } }),
        })

        -- LSP Keymaps
        local map_opts = { noremap = true, silent = true }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, map_opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, map_opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, map_opts)
    end,
}