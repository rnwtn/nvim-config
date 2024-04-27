return {
  "williamboman/mason.nvim",
  cmd = "Mason",
  event = "BufReadPre",
  opts = {
    ui = {
      border = "rounded",
    },
  },
  keys = {
    { "<leader>lI", "<cmd>Mason<cr>", desc = "Open Mason" },
  },
}
