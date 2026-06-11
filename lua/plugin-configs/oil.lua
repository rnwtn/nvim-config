return {
  src = "https://github.com/stevearc/oil.nvim",
  config = function()
    require("oil").setup({
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
        border = "single",
        padding = 5,
        max_width = 130,
        max_height = 80,
        win_options = {
          winblend = 0,
        },
      }
    });

    vim.keymap.set("n", "<leader>e", ":lua require('oil').open_float()<cr>")
    vim.keymap.set("n", "-", ":lua require('oil').open_float()<cr>")
    vim.keymap.set("n", "<RightMouse>", ":lua require('oil').open_float()<cr>")
  end,
}
