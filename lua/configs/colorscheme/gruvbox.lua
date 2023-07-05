return {
  "ellisonleao/gruvbox.nvim",
  name = "gruvbox",
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    local dimmed_bg = "#22201f"
    local telescope_bg = "#32302f"
    local telescope_bg2 = "#3c3836"
    local telescope_fg = "#f2e5bc"
    local telescope_green = "#b8bb26"
    local telescope_red = "#fb4934"

    require("gruvbox").setup {
      undercurl = true,
      underline = true,
      bold = true,
      italic = {
        string = true,
        comments = true,
        operators = false,
        folds = true,
      },
      strikethrough = true,
      invert_selection = false,
      invert_signs = false,
      invert_tabline = false,
      invert_intend_guides = false,
      inverse = true, -- invert background for search, diffs, statuslines and errors
      contrast = "", -- can be "hard", "soft" or empty string
      palette_overrides = {},
      overrides = {
        -- Telescope
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

        -- NeoTree
        NeoTreeNormal = { bg = dimmed_bg },
        NeoTreeNormalNC = { bg = dimmed_bg },

        -- Haropoon Tabline
        TabLineFill = { bg = dimmed_bg },
        HarpoonInactive = { bg = dimmed_bg  },
        HarpoonNumberInactive = { bg = dimmed_bg  },
        HarpoonActive = { bg = NONE  },
        HarpoonNumberActive = { bg = NONE  },
      },
      dim_inactive = false,
      transparent_mode = false,
    }
    vim.cmd "colorscheme gruvbox"
    -- vim.cmd "highlight! HarpoonInactive guibg=NONE guifg=#63698c"
    -- vim.cmd "highlight! HarpoonActive guibg=NONE guifg=white"
    -- vim.cmd "highlight! HarpoonNumberActive guibg=NONE guifg=#7aa2f7"
    -- vim.cmd "highlight! HarpoonNumberInactive guibg=NONE guifg=#7aa2f7"
    -- vim.cmd "highlight! TabLineFill guibg=NONE guifg=white"
  end,
}
