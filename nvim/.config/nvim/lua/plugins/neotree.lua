return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },

  config = function()


      -----------------------------------------------------------
      -- Keybindings
      -----------------------------------------------------------
      local map = vim.api.nvim_set_keymap
      local opts = { noremap = true, silent = true }
      map('n', '<leader>e', '<Cmd>Neotree toggle<CR>', opts)
  end,
}

