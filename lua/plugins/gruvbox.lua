local theme = "dark"
local function toggle_light_dark()
  if theme == "dark" then
    theme = "light"
  else
    theme = "dark"
  end
  vim.opt.background = theme
  vim.cmd("colorscheme gruvbox")
end

return {
  "ellisonleao/gruvbox.nvim",
  priority = 1000,
  opts = {
    -- transparent_mode = true,
    -- overrides = {
    --   Pmenu = { bg = "NONE" },
    -- },
    -- invert_selection = true,
    palette_overrides = {
      dark0 = "#171819",
      dark1 = "#282828",
      dark2 = "#282828",
      dark3 = "#282828",
    },
  },
  keys = {
    { "<leader>tt", toggle_light_dark, desc = "Theme toggle light/dark mode" },
  }
}
