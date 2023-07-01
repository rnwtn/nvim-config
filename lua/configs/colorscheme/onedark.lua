return {
  "navarasu/onedark.nvim",
  name = "onedark",
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    require("onedark").setup {
      -- Main options --
      style = "darker", -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
      transparent = false, -- Show/hide background
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
        comments = "italic",
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
        TelescopeBorder = { fg = "$bg1", bg = "$bg1" },
        TelescopeNormal = { bg = "bg2" },
        TelescopePreviewBorder = { fg = "$bg1", bg = "$bg1" },
        TelescopePreviewNormal = { bg = "$bg1" },
        TelescopePreviewTitle = { fg = "$bg1", bg = "$green" },
        TelescopePromptBorder = { fg = "$bg2", bg = "$bg2" },
        TelescopePromptNormal = { fg = "$fg", bg = "$bg2" },
        TelescopePromptPrefix = { fg = "$red", bg = "$bg2" },
        TelescopePromptTitle = { fg = "$bg1", bg = "$red" },
        TelescopeResultsBorder = { fg = "$bg1", bg = "$bg1" },
        TelescopeResultsNormal = { bg = "$bg1" },
        TelescopeResultsTitle = { fg = "$bg1", bg = "$bg1" },
        ZenBG = { bg = "#ff0000" },
        BufferLineNumbersSelected = { bg = "None", fg = "white" },
        BufferLineBufferSelected = { fg = "white", bg = "None" },
        BufferLineDiagnosticSelected = { bg = "None" },
        BufferLineHintSelected = { bg = "None" },
        BufferLineHintDiagnosticSelected = { bg = "None" },
        BufferLineInfoSelected = { bg = "None" },
        BufferLineInfoDiagnosticSelected = { bg = "None" },
        BufferLineWarningSelected = { bg = "None" },
        BufferLineWarningDiagnosticSelected = { bg = "None" },
        BufferLineErrorSelected = { bg = "None" },
        BufferLineErrorDiagnosticSelected = { bg = "None" },
        BufferLineModifiedSelected = { bg = "None" },
        BufferLineModifiedDiagnosticSelected = { bg = "None" },
        BufferLineDuplicateSelected = { bg = "None" },
        BufferLineSeparatorSelected = { bg = "None" },
      },

      -- Plugins Config --
      diagnostics = {
        darker = true, -- darker colors for diagnostic
        undercurl = true, -- use undercurl instead of underline for diagnostics
        background = true, -- use background color for virtual text
      },
    }

    require("onedark").load()
    vim.cmd([[set background=dark]])
  end,
}
