return {
  "ThePrimeagen/harpoon",
  event = "BufEnter",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require "harpoon"

    -- REQUIRED
    harpoon:setup()
    -- REQUIRED

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set("n", "<leader>[", function()
      harpoon:list():prev()
    end)
    vim.keymap.set("n", "<leader>]", function()
      harpoon:list():next()
    end)
  end,
  keys = {
    { "<leader>a", ":lua require('harpoon'):list():append()<cr>", desc = "Add buffer to Harpoon list" },
    {
      "<leader>s",
      ":lua require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())<cr>",
      desc = "Open Harpoon quick menu",
    },
    { "<leader>u", ":lua require('harpoon'):list():select(1)<cr>",         desc = "Navigate to Harpoon file 1" },
    { "<leader>i", ":lua require('harpoon'):list():select(2)<cr>",         desc = "Navigate to Harpoon file 2" },
    { "<leader>o", ":lua require('harpoon'):list():select(3)<cr>",         desc = "Navigate to Harpoon file 3" },
    { "<leader>p", ":lua require('harpoon'):list():select(4)<cr>",         desc = "Navigate to Harpoon file 4" },
    { "<leader>[", ":lua require('harpoon'):list():prev()<cr>",         desc = "Navigate to Harpoon previous file" },
    { "<leader>]", ":lua require('harpoon'):list():next()<cr>",         desc = "Navigate to Harpoon next file" },
  },
}
