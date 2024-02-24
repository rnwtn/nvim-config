return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "BufRead",
  config = function()
    require("copilot").setup {
      -- disable so suggestions are from cmp
      suggestion = { enabled = false },
      panel = { enabled = false },
    }
  end,
}
