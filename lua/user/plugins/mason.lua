return {
  "williamboman/mason.nvim",
  cmd = "Mason",
  event = "BufReadPre",
  dependencies = {
    {
      "williamboman/mason-lspconfig.nvim",
      lazy = true,
    },
  },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup()
  end,
}
