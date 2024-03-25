
-- Set the working directory to the directory containing init.lua
local original_cwd = vim.fn.getcwd()
vim.cmd('cd ' .. vim.fn.expand('~/.config/nvim'))

-- Clone Packer if not installed yet
local packer_path = vim.fn.stdpath('config')..'/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(packer_path)) > 0 then
    vim.cmd('!git clone --depth 1 https://github.com/wbthomason/packer.nvim ' .. packer_path)
end



-- Initialize Packer
require('packer').startup(function(use)

    -- Packer and essential plugins
    use {'wbthomason/packer.nvim', 'nvim-lua/plenary.nvim'}

    -- File explorer and icons
    use {
		'nvim-tree/nvim-web-devicons',
		'preservim/nerdtree'
	}

    -- LaTeX support
    use 'lervag/vimtex'

	use 'brennier/quicktex'
	use 'nvim-tree/nvim-tree.lua'


    -- Status Line
    use {
        'nvim-lualine/lualine.nvim',
        requires = {'nvim-tree/nvim-web-devicons'},
    }

    -- Commenting
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    -- Treesitter
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}


	-- Autocompletion
	use {
    'L3MON4D3/LuaSnip',
	}

	use 'hrsh7th/cmp-nvim-lua'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/nvim-cmp'
	use 'saadparwaiz1/cmp_luasnip'

    -- Mason
    use {
		'williamboman/mason.nvim',
		'williamboman/mason-lspconfig.nvim',
		'neovim/nvim-lspconfig'
	}

    -- Miscellaneous plugins
    use {
		'lewis6991/gitsigns.nvim',
		'romgrk/barbar.nvim'
	}

	-- Colorschemes
	use {
		'Alexis12119/nightly.nvim',
	}

    -- Telescope
    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.5',
        requires = {'nvim-lua/plenary.nvim'}
    }

    -- Terminal
    use {
        'akinsho/toggleterm.nvim',
        tag = '*',
        config = function()
            require('toggleterm').setup()
        end
    }

	use 'tpope/vim-surround'

	use {
		"windwp/nvim-autopairs",
		config = function() require("nvim-autopairs").setup {} end
	}

	use {
	  "olrtg/nvim-emmet",
	  config = function()
		vim.keymap.set({ "n", "v" }, '<leader>xe', require('nvim-emmet').wrap_with_abbreviation)
	  end,
	}

	use {"tpope/vim-fugitive"}

	use({
	  "epwalsh/obsidian.nvim",
	  tag = "*",
	  requires = {
		"nvim-lua/plenary.nvim",
	  },
	  config = function()
		require("obsidian").setup({
		  workspaces = {
			{
			  name = "personal",
			  path = "~/Obsidian/Personal Vault",
			},
		  },
		  completion = {
			nvim_cmp = true,
			min_chars = 2,
		  },

		  mappings = {
			["gf"] = {
			  action = function()
				return require("obsidian").util.gf_passthrough()
			  end,
			  opts = { noremap = false, expr = true, buffer = true },
			},
			["<leader>ch"] = {
			  action = function()
				return require("obsidian").util.toggle_checkbox()
			  end,
			  opts = { buffer = true },
			},
		  },
			})
		  end,
		})

    use {
      'abecodes/tabout.nvim',
      config = function()
        require('tabout').setup {
        tabkey = '<Tab>', -- key to trigger tabout, set to an empty string to disable
        backwards_tabkey = '<S-Tab>', -- key to trigger backwards tabout, set to an empty string to disable
        act_as_tab = true, -- shift content if tab out is not possible
        act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
        default_tab = '<C-t>', -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
        default_shift_tab = '<C-d>', -- reverse shift default action,
        enable_backwards = true, -- well ...
        completion = true, -- if the tabkey is used in a completion pum
        tabouts = {
          {open = "'", close = "'"},
          {open = '"', close = '"'},
          {open = '`', close = '`'},
          {open = '(', close = ')'},
          {open = '[', close = ']'},
          {open = '{', close = '}'}
        },
        ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
        exclude = {} -- tabout will ignore these filetypes
    }
      end,
        wants = {'nvim-treesitter'}, -- or require if not used so far
        after = {'nvim-cmp'} -- if a completion plugin is using tabs load it before
    }

end)

-- Set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- Other configurations
require('config')
require('config.init')
require('other.init')
require('keymaps')

vim.cmd('cd ' .. original_cwd)

