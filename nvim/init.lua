local vim = vim or {} -- Avoid undefined global 'vim' error

-- Set the working directory to the directory containing init.lua
local original_cwd = vim.fn.getcwd()
vim.cmd('cd ' .. vim.fn.expand('~/.config/nvim'))

-- Clone Packer if not installed yet
local packer_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(packer_path)) > 0 then
    vim.cmd('!git clone --depth 1 https://github.com/wbthomason/packer.nvim ' .. packer_path)
end

-- Initialize Packer
require('packer').startup(function(use)
    
    use 'wbthomason/packer.nvim'		-- Packer
	use 'nvim-lua/plenary.nvim'
	use 'nvim-tree/nvim-web-devicons' 	-- DevIcons
    use 'preservim/nerdtree'			-- Nerdtree
    use 'lervag/vimtex'					-- Vimtex
  	use 'morhetz/gruvbox'				-- colorscheme 
	use { "catppuccin/nvim", as = "catppuccin" }

	-- Lualine
	use {
		  'nvim-lualine/lualine.nvim',
		  requires = { 'nvim-tree/nvim-web-devicons', opt = true }
	}

	-- Comment
	use {
		'numToStr/Comment.nvim',
		config = function()
		require('Comment').setup()
		end
	}

	-- Treesitter
	use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})

	-- lasp-zero
	use {
	  'VonHeikemen/lsp-zero.nvim',
	  branch = 'v3.x',
	  requires = {

		-- LSP Support
		{'neovim/nvim-lspconfig'},
	
		-- Autocompletion
		{'hrsh7th/nvim-cmp'},
		{'hrsh7th/cmp-nvim-lsp'},
		{'L3MON4D3/LuaSnip'},
	  }
	}
	
	-- Mason
	use {
	    "williamboman/mason.nvim",
	    "williamboman/mason-lspconfig.nvim",
	    "neovim/nvim-lspconfig",
	}

	use 'latex-lsp/texlab'
	use "Alexis12119/nightly.nvim"

	use 'neomake/neomake'

	-- These optional plugins should be loaded directly because of a bug in Packer lazy loading
	use 'lewis6991/itsigns.nvim' -- OPTIONAL: for git status
	use 'nvim-tree/nvim-web-devicons' -- OPTIONAL: for file icons
	use 'romgrk/barbar.nvim'

end)


-- Set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- Other configurations
require('plugin_conf.init')
require('config')
require('keymaps')


vim.cmd('cd ' .. original_cwd)
