return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    indent = { enabled = false },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    words = { enabled = true },
    zen = {
      enabled = true,
      toggles = {
        dim = false,
      },
    },
  },
  keys = {
    { "<leader>z", ":lua require('snacks').zen()<cr>" },
  },
}
