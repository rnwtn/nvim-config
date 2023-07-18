return {
  "hood/popui.nvim",
  event = "VimEnter",
  config = function()
    vim.ui.select = require "popui.ui-overrider"
    vim.ui.input = require "popui.input-overrider"

    -- Available styles: "sharp" | "rounded" | "double"
    vim.g.popui_border_style = "rounded"
  end,
}
