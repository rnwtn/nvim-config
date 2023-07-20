return {
  "williamboman/mason.nvim",
  cmd = "Mason",
  event = "BufReadPre",
  opts = {},
  keys = {
    { "<leader>lI", "<cmd>Mason<cr>", desc = "Open Mason" },
  },
}
