return {
  {
    "ellisonleao/gruvbox.nvim",
    name = "gruvbox",
    lazy = false,
    priority = 1000,
    config = function()
      local dimmed_bg = "#22201f"
      local telescope_bg = "#32302f"
      local telescope_bg2 = "#3c3836"
      local telescope_fg = "#f2e5bc"
      local telescope_green = "#b8bb26"
      local telescope_red = "#fb4934"

      require("gruvbox").setup {
        invert_selection = true,
        overrides = {
          NormalFloat = { bg = telescope_bg },
          FloatBorder = { bg = telescope_bg, fg = telescope_fg },
          TabLineFill = { bg = dimmed_bg },
          TelescopeBorder = { fg = telescope_bg, bg = telescope_bg },
          TelescopeNormal = { bg = telescope_bg2 },
          TelescopePreviewBorder = { fg = telescope_bg, bg = telescope_bg },
          TelescopePreviewNormal = { bg = telescope_bg },
          TelescopePreviewTitle = { fg = telescope_bg, bg = telescope_green },
          TelescopePromptBorder = { fg = telescope_bg2, bg = telescope_bg2 },
          TelescopePromptNormal = { fg = telescope_fg, bg = telescope_bg2 },
          TelescopePromptPrefix = { fg = telescope_red, bg = telescope_bg2 },
          TelescopePromptTitle = { fg = telescope_bg, bg = telescope_red },
          TelescopeResultsBorder = { fg = telescope_bg, bg = telescope_bg },
          TelescopeResultsNormal = { bg = telescope_bg },
          TelescopeResultsTitle = { fg = telescope_bg, bg = telescope_bg },
          HarpoonInactive = { bg = dimmed_bg },
          HarpoonNumberInactive = { bg = dimmed_bg },
          HarpoonActive = { bg = "NONE" },
          HarpoonNumberActive = { bg = "NONE" },
        },
      }
    end,
  },
  {
    "neanias/everforest-nvim",
    version = false,
    lazy = false,
    priority = 1000,
    config = function()
      require("everforest").setup {
        ui_contrast = "high",
        on_highlights = function(hl, palette)
          hl.NormalFloat = { bg = palette.none }
          hl.FloatBorder = { bg = palette.none, fg = palette.fg }
          hl.TelescopeBorder = { fg = palette.none, bg = palette.none }
          hl.TelescopeNormal = { bg = palette.grey1 }
          hl.TelescopePreviewBorder = { fg = palette.bg1, bg = palette.bg1 }
          hl.TelescopePreviewNormal = { bg = palette.bg1 }
          hl.TelescopePreviewTitle = { fg = palette.none, bg = palette.green }
          hl.TelescopePromptBorder = { fg = palette.bg2, bg = palette.bg2 }
          hl.TelescopePromptNormal = { fg = palette.fg, bg = palette.bg2 }
          hl.TelescopePromptPrefix = { fg = palette.red, bg = palette.bg2 }
          hl.TelescopePromptTitle = { fg = palette.none, bg = palette.red }
          hl.TelescopeResultsBorder = { fg = palette.bg1, bg = palette.bg1 }
          hl.TelescopeResultsNormal = { bg = palette.bg1 }
          hl.TelescopeResultsTitle = { fg = palette.bg1, bg = palette.bg1 }
        end,
      }
    end,
  },
}
