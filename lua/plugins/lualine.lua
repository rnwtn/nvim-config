return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "linrongbin16/lsp-progress.nvim",
  },
  config = function()
    require("lsp-progress").setup()
    require("lualine").setup({
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
        lualine_c = {
          require("lsp-progress").progress,
        },
        lualine_x = {
          -- {
          --   require("noice").api.statusline.mode.get,
          --   cond = require("noice").api.statusline.mode.has,
          --   color = { fg = "#ff9e64" },
          -- },
          "encoding",
          "fileformat",
          "filetype",
        },
      },
    })
  end,
}
