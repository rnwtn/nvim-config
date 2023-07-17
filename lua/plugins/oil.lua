return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VimEnter",
  config = function()
    require("oil").setup({
      keymaps = {
        ["<leader>e"] = "actions.close",
        ["q"] = "actions.close"
      }
    })
    vim.keymap.set("n", "<leader>e", require("oil").open_float, { desc = "Open parent directory" })
  end,
}
