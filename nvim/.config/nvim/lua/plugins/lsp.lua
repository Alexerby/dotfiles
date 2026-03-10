return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "quangnguyen30192/cmp-nvim-ultisnips",
        "nvimtools/none-ls.nvim",
        "dcampos/cmp-emmet-vim",
    },

    config = function()
        local lspconfig = require("lspconfig")
        local cmp = require("cmp")
        local cmp_lsp = require("cmp_nvim_lsp")
        local util = require("lspconfig.util")

        -----------------------------------------------------------
        -- Diagnostics
        -----------------------------------------------------------
        vim.diagnostic.config({
            virtual_text = { prefix = "●", spacing = 2 },
            signs = true,
            underline = true,
            update_in_insert = true,
            severity_sort = true,
            float = { focusable = false, style = "minimal", border = "rounded", source = "always" },
        })

        -----------------------------------------------------------
        -- Capabilities
        -----------------------------------------------------------
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities()
        )

        -----------------------------------------------------------
        -- Mason & Server Setup
        -----------------------------------------------------------
        require("mason").setup()
        
        -- Use setup_handlers to prevent the 'vim.lsp.enable' nil crash on 0.10.4
        require("mason-lspconfig").setup({
            ensure_installed = { "lua_ls", "pyright", "ruff", "texlab", "clangd", "ts_ls" },
        })

        local function setup_server(server_name, opts)
            opts = opts or {}
            opts.capabilities = capabilities
            if lspconfig[server_name] then
                lspconfig[server_name].setup(opts)
            else
                vim.notify("LSP Config not found for: " .. server_name, vim.log.levels.ERROR)
            end
        end

        -----------------------------------------------------------
        -- Custom Server Configurations
        -----------------------------------------------------------

        -- Python
        setup_server("pyright", {
            on_attach = function(client, bufnr)
                client.server_capabilities.documentFormattingProvider = false
            end,
            root_dir = util.root_pattern("pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git"),
            settings = {
                python = {
                    analysis = {
                        typeCheckingMode = "basic",
                        autoSearchPaths = true,
                        useLibraryCodeForTypes = true,
                    },
                },
            },
        })

        -- Lua
        setup_server("lua_ls", {
            settings = {
                Lua = {
                    runtime = { version = "Lua 5.1" },
                    diagnostics = {
                        globals = { "vim", "bit", "it", "describe", "before_each", "after_each" },
                    },
                },
            },
        })

        -- Typescript (ts_ls)
        setup_server("ts_ls", {
            -- Stable root detection for 0.10.4
            root_dir = util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
            single_file_support = true,
        })

        -- Generic servers
        local generic_servers = { "clangd", "ruff", "texlab" }
        for _, s in ipairs(generic_servers) do
            setup_server(s)
        end

        -----------------------------------------------------------
        -- nvim-cmp setup
        -----------------------------------------------------------
        cmp.setup({
            snippet = {
                expand = function(args)
                    vim.fn["UltiSnips#Anon"](args.body)
                end,
            },
            mapping = {
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
                ["<C-j>"] = cmp.mapping.select_next_item(),
                ["<C-k>"] = cmp.mapping.select_prev_item(),
            },
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "ultisnips" },
                { name = "emmet_vim" },
            }, {
                { name = "buffer" },
            }),
        })

        -----------------------------------------------------------
        -- Keybindings
        -----------------------------------------------------------
        local opts = { noremap = true, silent = true }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "dg", "<cmd>nohlsearch<CR>", opts)
    end,
}
