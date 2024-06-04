return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VimEnter",
  opts = {
    view_options = {
      show_hidden = true,
    },
    keymaps = {
      ["<leader>e"] = "actions.close",
      ["q"] = "actions.close",
      ["<2-LeftMouse>"] = "actions.select",
      ["<RightMouse>"] = "actions.parent",
      ["<2-RightMouse>"] = "actions.parent",
      ["<3-RightMouse>"] = "actions.parent",
      ["<4-RightMouse>"] = "actions.parent",
      ["<C-j>"] = "j",
      ["<C-k>"] = "k",
      ["<Tab>"] = "j",
      ["<S-Tab>"] = "k",
    },
    float = {
      padding = 5,
      max_width = 130,
      max_height = 80,
      win_options = {
        winblend = 0,
      },
    },
  },
  keys = {
    { "<leader>e", ":lua require('oil').open_float()<cr>", desc = "Open parent directory" },
    { "-", ":lua require('oil').open_float()<cr>", desc = "Open parent directory" },
    { "<RightMouse>", ":lua require('oil').open_float()<cr>", desc = "Open parent directory" },
  },
}
