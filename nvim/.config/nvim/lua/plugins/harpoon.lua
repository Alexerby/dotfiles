return {
  "ThePrimeagen/harpoon",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("harpoon").setup()
  end,
  keys = {
    -- Add file
    { "<leader>ha", function() require("harpoon.mark").add_file() end, desc = "Harpoon Add File" },
    -- Toggle menu
    { "<leader>hu", function() require("harpoon.ui").toggle_quick_menu() end, desc = "Harpoon Quick Menu" },
    -- Navigate to file 1-4
    { "<leader>1", function() require("harpoon.ui").nav_file(1) end, desc = "Harpoon File 1" },
    { "<leader>2", function() require("harpoon.ui").nav_file(2) end, desc = "Harpoon File 2" },
    { "<leader>3", function() require("harpoon.ui").nav_file(3) end, desc = "Harpoon File 3" },
    { "<leader>4", function() require("harpoon.ui").nav_file(4) end, desc = "Harpoon File 4" },
  },
}
