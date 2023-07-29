return {
  "folke/trouble.nvim",
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {},
  keys = {
    { "<leader>lD", ":Trouble<cr>", desc = "Trouble toggle"}
  }
}
