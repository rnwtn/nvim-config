return {
    "ellisonleao/gruvbox.nvim",
    name = "gruvbox",
    lazy = false,
    priority = 1000,
    config = function()
      local fg = "#f2e5bc"

      require("gruvbox").setup({
        invert_selection = true,
        transparent_mode = true,
        overrides = {
          Normal = { bg = "NONE" },
          NormalFloat = { bg = "NONE" },
          FloatBorder = { bg = "NONE", fg = fg },
          LspInfoBorder = { bg = "NONE", fg = fg },
        },
        italic = {
          -- strings = false,
          -- comments = false,
          -- operators = false,
          -- folds = false,
        },
      })
    end,
  },
  {
    "neanias/everforest-nvim",
    version = false,
    lazy = false,
    priority = 1000,
    config = function()
      require("everforest").setup({
        ui_contrast = "high",
        transparent_background_level = 2,
        on_highlights = function(hl, palette)
          hl.NormalFloat = { bg = palette.none }
          hl.FloatBorder = { bg = palette.none, fg = palette.fg }
          hl.LspInfoBorder = { fg = palette.fg }
        end,
      })
    end,
}

-- For NvChad like telescope theme, do something like the following
--local dimmed_bg = "#22201f"
--local telescope_bg = "#32302f"
--local telescope_bg2 = "#3c3836"
--local telescope_fg = "#f2e5bc"
--local telescope_green = "#b8bb26"
--local telescope_red = "#fb4934"
--
--TabLineFill = { bg = dimmed_bg },
--TelescopeBorder = { fg = telescope_bg, bg = telescope_bg },
--TelescopeNormal = { bg = telescope_bg2 },
--TelescopePreviewBorder = { fg = telescope_bg, bg = telescope_bg },
--TelescopePreviewNormal = { bg = telescope_bg },
--TelescopePreviewTitle = { fg = telescope_bg, bg = telescope_green },
--TelescopePromptBorder = { fg = telescope_bg2, bg = telescope_bg2 },
--TelescopePromptNormal = { fg = telescope_fg, bg = telescope_bg2 },
--TelescopePromptPrefix = { fg = telescope_red, bg = telescope_bg2 },
--TelescopePromptTitle = { fg = telescope_bg, bg = telescope_red },
--TelescopeResultsBorder = { fg = telescope_bg, bg = telescope_bg },
--TelescopeResultsNormal = { bg = telescope_bg },
--TelescopeResultsTitle = { fg = telescope_bg, bg = telescope_bg },
--HarpoonInactive = { bg = dimmed_bg },
--HarpoonNumberInactive = { bg = dimmed_bg },
--HarpoonActive = { bg = "NONE" },
--HarpoonNumberActive = { bg = "NONE" },
