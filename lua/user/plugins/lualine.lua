return {
  "nvim-lualine/lualine.nvim",
  depends = { "folke/noice.nvim" },
  event = { "VimEnter" },
  opts = {
    options = {
      icons_enabled = true,
      theme = "auto",
      component_separators = { left = "|", right = "|" },
      section_separators = { left = "", right = "" },
      refresh = {
        statusline = 500,
      },
    },
    sections = {
      lualine_x = {
        {
          require("noice").api.statusline.mode.get,
          cond = require("noice").api.statusline.mode.has,
          color = { fg = "#ff9e64" },
        },
        "encoding",
        "fileformat",
        "filetype",
      },
    },
  },
}
