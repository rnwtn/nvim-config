local theme = "dark"

local function toggle_light_dark()
  theme = theme == "dark" and "light" or "dark"

  vim.opt.background = theme
  vim.cmd.colorscheme("gruvbox")
end

return {
  src = "https://github.com/ellisonleao/gruvbox.nvim",
  config = function()
    require("gruvbox").setup({
      invert_selection = true,
      palette_overrides = {
        dark0 = "#171819",
        dark1 = "#282828",
        dark2 = "#282828",
        dark3 = "#282828",
      },
    })

    vim.keymap.set("n", "<leader>tt", toggle_light_dark)
    vim.cmd.colorscheme("gruvbox")
  end,
}
