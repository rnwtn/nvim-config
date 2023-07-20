return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VimEnter",
  opts = {
    keymaps = {
      ["<leader>e"] = "actions.close",
      ["q"] = "actions.close",
    },
    float = {
      padding = 5,
      max_width = 100,
      max_height = 80,
      win_options = {
        winblend = 0,
      },
    },
  },
  keys = {
    { "<leader>e", ":lua require('oil').open()<cr>", desc = "Open parent directory" },
    { "<leader>fe", ":lua require('oil').open_float()<cr>", desc = "Open parent directory" },
  },
}
