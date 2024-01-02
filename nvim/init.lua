local vim = vim or {} -- Avoid undefined global 'vim' error

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

	require'nvim-tree'.setup {}

    -- LaTeX support
    use {
	'lervag/vimtex',
	}

	use 'brennier/quicktex'

	use {
	  'nvim-tree/nvim-tree.lua',
	}

    -- Colorscheme
    use 'morhetz/gruvbox'

    -- Statusline
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

    -- LSP and completion
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            'neovim/nvim-lspconfig',
            'hrsh7th/nvim-cmp',
            {'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip'},
        }
    }

    -- Mason
    use {
		'williamboman/mason.nvim',
		'williamboman/mason-lspconfig.nvim',
		'neovim/nvim-lspconfig'
	}

    -- Miscellaneous plugins
    use {
		'neomake/neomake',
		'Alexis12119/nightly.nvim',
		'lewis6991/gitsigns.nvim',
		'romgrk/barbar.nvim'
	}

    -- Autopairs
    use {
        'windwp/nvim-autopairs',
        config = function()
            require('nvim-autopairs').setup {}
        end
    }

    -- Syntax highlighting
    use 'numirias/semshi'

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

	use {'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async'}
	use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'saadparwaiz1/cmp_luasnip'
	use 'rafamadriz/friendly-snippets'
	
end)


-- Set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- Other configurations
require('config')
require('plugin_conf.init')

-- Your key mappings
vim.api.nvim_set_keymap('n', '<leader>t', ':ToggleTerm<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<leader>t', '<C-\\><C-n><cmd>ToggleTerm<CR>', { noremap = true, silent = true })
require('other.init')


vim.cmd('cd ' .. original_cwd)

