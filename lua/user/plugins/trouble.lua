return {
  "folke/trouble.nvim",
  event = "LspAttach",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {},
  keys = {
    { "<leader>lD", ":Trouble<cr>", desc = "Trouble toggle"}
  }
}
