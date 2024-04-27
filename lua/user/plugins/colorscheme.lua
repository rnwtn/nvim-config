return {
  {
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
          strings = false,
          comments = false,
          operators = false,
          folds = false,
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
  },
  {
    "navarasu/onedark.nvim",
    name = "onedark",
    lazy = false,
    priority = 1000,
    config = function()
      require("onedark").setup({
        -- Main options --
        style = "deep", -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
        transparent = true, -- Show/hide background
        term_colors = true, -- Change terminal color as per the selected theme style
        ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
        cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

        -- toggle theme style ---
        toggle_style_key = "<leader>ts", -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
        toggle_style_list = { "dark", "darker", "cool", "deep", "warm", "warmer", "light" }, -- List of styles to toggle between

        -- Change code style ---
        -- Options are italic, bold, underline, none
        -- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
        code_style = {
          comments = "none",
          keywords = "none",
          functions = "none",
          strings = "none",
          variables = "none",
        },

        -- Lualine options --
        lualine = {
          transparent = false, -- lualine center bar transparency
        },

        -- Custom Highlights --
        colors = {}, -- Override default colors
        highlights = {
          NormalFloat = { bg = "none" },
          FloatBorder = { bg = "none", fg = "$fg" },
          TelescopeBorder = { fg = "$fg" },
          TelescopeNormal = { fg = "$fg" },
          TelescopePreviewBorder = { fg = "$fg" },
          TelescopePromptBorder = { fg = "$fg" },
          TelescopeResultsBorder = { fg = "$fg" },
          TelescopePromptPrefix = { fg = "$red" },
          TelescopeSelectionCaret = { fg = "$red" },
          LspInfoBorder = { fg = "$fg" },
        },

        -- Plugins Config --
        diagnostics = {
          darker = true, -- darker colors for diagnostic
          undercurl = true, -- use undercurl instead of underline for diagnostics
          background = true, -- use background color for virtual text
        },
      })
    end,
  },
}

-- For NvChad like telescope theme, do something like the following
--local dimmed_bg = "#22201f"
--local telescope_bg = "#32302f"
--local telescope_bg2 = "#3c3836"
--local telescope_fg = "#f2e5bc"
--local telescope_green = "#b8bb26"
--local telescope_red = "#fb4934"
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
