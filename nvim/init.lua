-- init.lua

-- Set the working directory to the directory containing init.lua
local original_cwd = vim.fn.getcwd()
vim.cmd('cd ' .. vim.fn.expand('~/.config/nvim'))

-- Clone Packer if not installed yet
local packer_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(packer_path)) > 0 then
    vim.cmd('!git clone --depth 1 https://github.com/wbthomason/packer.nvim ' .. packer_path)
end

-- Initialize Packer
require('packer').startup(function()
    
    use 'wbthomason/packer.nvim'		-- Packer
    use 'preservim/nerdtree'			-- Nerdtree
    use 'lervag/vimtex'					-- Vimtex
  	use 'morhetz/gruvbox'				-- colorscheme 
	use 'nvim-tree/nvim-web-devicons' 	-- DevIcons
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

end)



-- Set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- Other configurations
require('plugin_conf.init')
require('config')
require('keymaps')
require("nvim-web-devicons").refresh()


vim.cmd('cd ' .. original_cwd)
