return {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = false,
    ft = "markdown",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    opts = {
        workspaces = {
            { name = "school", path = "~/vaults/school" },
        },
        ui = { enable = false },
        disable_frontmatter = false,

        attachments = {
            img_folder = "attachments",
            img_name_func = function() return tostring(os.time()) end,
        },
        templates = {
            folder = "templates",
            date_format = "%Y-%m-%d-%a",
            time_format = "%H:%M",
        },

        note_id_func = function(title)
            local suffix = ""
            for _ = 1, 4 do
                local val = math.random(0, 35)
                if val < 10 then
                    suffix = suffix .. val
                else
                    suffix = suffix .. string.char(val + 87)
                end
            end

            local base_id = ""
            if title ~= nil then
                base_id = title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower()
            else
                base_id = tostring(os.time())
            end

            return base_id .. "-" .. suffix
        end,

        -- note_id_func = function(title)
        --     return title
        -- end,

        note_path_func = function(spec)
            local path = spec.dir / tostring(spec.id)
            return path:with_suffix '.md'
        end,
    },

    config = function(_, opts)
        require("obsidian").setup(opts)

        local map = vim.keymap.set
        local kopts = { silent = true }

        -- Ensure your Trash path is correct for your distro
        local delete_to_trash_cmd = ':!mv "%" ' .. vim.fn.expand('~') .. '/.local/share/Trash/files/' .. '<CR>:bdelete!<CR>'
        
        map('n', '<leader>on', ':ObsidianNew<CR>', kopts)
        map('v', '<leader>on', ':ObsidianLinkNew<CR>', kopts)
        map('n', '<leader>or', ':ObsidianRename<CR>', kopts)
        map('n', '<leader>oo', ':ObsidianOpen<CR>', kopts)
        map('n', '<leader>os', ':ObsidianSearch<CR>', kopts)
        map('n', '<leader>ot', ':ObsidianTags<CR>', kopts)
        map('n', '<leader>ow', ':ObsidianWorkspace<CR>', kopts)
        map('v', '<leader>oe', ':ObsidianExtractNote<CR>', kopts)

        map('n', '<leader>odf', delete_to_trash_cmd, kopts)

        map('n', '<leader>ol', ':ObsidianFollowLink<CR>', kopts)
        map('v', '<leader>ol', ':ObsidianLink<CR>', kopts)

        -- Fixed Image Paste Function
        map('n', '<leader>op', function()
            local obsidian = require("obsidian")
            local client = obsidian.get_client() -- Changed from (0) to () to get current client safely

            if not client then
                print("Not in an Obsidian vault!")
                return
            end

            local img_name = tostring(os.time()) .. ".png"
            local img_folder = client.dir / "attachments"
            local img_path = img_folder / img_name

            -- Ensure folder exists
            img_folder:mkdir({ parents = true, exists_ok = true })

            local cmd = string.format("wl-paste --no-newline --type image/png > '%s'", tostring(img_path))
            local result = os.execute(cmd)

            if result == 0 then
                -- Use relative path for the link in Markdown
                local rel_path = "attachments/" .. img_name
                local link = string.format("![%s](%s)", img_name, rel_path)
                vim.api.nvim_put({ link }, "c", true, true)
            else
                print("Error: Clipboard does not contain an image (or wl-paste failed)")
            end
        end, kopts)
    end,
}
