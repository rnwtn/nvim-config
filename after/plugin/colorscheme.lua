-- Lua
require('onedark').setup {
  -- Main options --
  style = 'darker', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
  transparent = false, -- Show/hide background
  term_colors = true, -- Change terminal color as per the selected theme style
  ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
  cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

  -- toggle theme style ---
  toggle_style_key = '<leader>ts', -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
  toggle_style_list = { 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light' }, -- List of styles to toggle between

  -- Change code style ---
  -- Options are italic, bold, underline, none
  -- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
  code_style = {
    comments = 'italic',
    keywords = 'none',
    functions = 'none',
    strings = 'none',
    variables = 'none'
  },

  -- Lualine options --
  lualine = {
    transparent = false, -- lualine center bar transparency
  },

  -- Custom Highlights --
  colors = {}, -- Override default colors
  highlights = {
    TelescopeBorder = { fg = '$bg1', bg = '$bg1' },
    TelescopeNormal = { bg = 'bg2' },
    TelescopePreviewBorder = { fg = '$bg1', bg = '$bg1' },
    TelescopePreviewNormal = { bg = '$bg1' },
    TelescopePreviewTitle = { fg = '$bg1', bg = '$green' },
    TelescopePromptBorder = { fg = '$bg2', bg = '$bg2' },
    TelescopePromptNormal = { fg = '$fg', bg = '$bg2' },
    TelescopePromptPrefix = { fg = '$red', bg = '$bg2' },
    TelescopePromptTitle = { fg = '$bg1', bg = '$red' },
    TelescopeResultsBorder = { fg = '$bg1', bg = '$bg1' },
    TelescopeResultsNormal = { bg = '$bg1' },
    TelescopeResultsTitle = { fg = '$bg1', bg = '$bg1' },
  },

  -- Plugins Config --
  diagnostics = {
    darker = true, -- darker colors for diagnostic
    undercurl = true, -- use undercurl instead of underline for diagnostics
    background = true, -- use background color for virtual text
  },
}
require('onedark').load()

-- -- setup must be called before loading the colorscheme
-- -- Default options:
--
-- local telescope_bg = '#32302f'
-- local telescope_bg2 = '#3c3836'
-- local telescope_fg = '#f2e5bc'
-- local telescope_green = '#b8bb26'
-- local telescope_red = '#fb4934'
--
-- require("gruvbox").setup({
--   undercurl = true,
--   underline = true,
--   bold = true,
--   italic = true,
--   strikethrough = true,
--   invert_selection = false,
--   invert_signs = false,
--   invert_tabline = false,
--   invert_intend_guides = false,
--   inverse = true, -- invert background for search, diffs, statuslines and errors
--   contrast = "", -- can be "hard", "soft" or empty string
--   palette_overrides = {},
--   overrides = {
--      -- TelescopeBorder = { fg = '$bg2', bg = '$bg1' },
--      -- TelescopeNormal = { bg = '$bg1' },
--      TelescopePreviewBorder = { fg = telescope_bg, bg = telescope_bg },
--      TelescopePreviewNormal = { bg = telescope_bg },
--      TelescopePreviewTitle = { fg = telescope_bg, bg = telescope_green },
--      TelescopePromptBorder = { fg = telescope_bg2, bg = telescope_bg2 },
--      TelescopePromptNormal = { fg = telescope_fg, bg = telescope_bg2 },
--      TelescopePromptPrefix = { fg = telescope_red, bg = telescope_bg2 },
--      TelescopePromptTitle = { fg = telescope_bg, bg = telescope_red },
--      TelescopeResultsBorder = { fg = telescope_bg, bg = telescope_bg },
--      TelescopeResultsNormal = { bg = telescope_bg },
--      TelescopeResultsTitle = { fg = telescope_bg, bg = telescope_bg },
--   },
--   dim_inactive = false,
--   transparent_mode = false,
-- })
--
-- vim.cmd("colorscheme gruvbox")
