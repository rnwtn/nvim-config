local M = {
  "ellisonleao/gruvbox.nvim",
  lazy = false,    -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
}
M.name = "gruvbox"

local tree_bg = '#22201f'
local telescope_bg = '#32302f'
local telescope_bg2 = '#3c3836'
local telescope_fg = '#f2e5bc'
local telescope_green = '#b8bb26'
local telescope_red = '#fb4934'

function M.config()
  require("gruvbox").setup({
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
    contrast = "",  -- can be "hard", "soft" or empty string
    palette_overrides = {},
    overrides = {
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
      BufferLineNumbersSelected = { bg = 'None', fg = 'white' },
      BufferLineBufferSelected = { fg = 'white', bg = 'None' },
      BufferLineDiagnosticSelected = { bg = 'None' },
      BufferLineHintSelected = { bg = 'None' },
      BufferLineHintDiagnosticSelected = { bg = 'None' },
      BufferLineInfoSelected = { bg = 'None' },
      BufferLineInfoDiagnosticSelected = { bg = 'None' },
      BufferLineWarningSelected = { bg = 'None' },
      BufferLineWarningDiagnosticSelected = { bg = 'None' },
      BufferLineErrorSelected = { bg = 'None' },
      BufferLineErrorDiagnosticSelected = { bg = 'None' },
      BufferLineModifiedSelected = { bg = 'None' },
      BufferLineModifiedDiagnosticSelected = { bg = 'None' },
      BufferLineDuplicateSelected = { bg = 'None' },
      BufferLineSeparatorSelected = { bg = 'None' },
      NvimTreeNormal = { bg = tree_bg },
    },
    dim_inactive = false,
    transparent_mode = false,
  })
  vim.cmd("colorscheme gruvbox")
end

return M
