local M = {
  "nvim-lualine/lualine.nvim",
  event = { "VimEnter" },
}

function M.config()
  local lualine = require "lualine"

  local hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end

  local diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    sections = { "error", "warn" },
    symbols = { error = " ", warn = " " },
    colored = false,
    always_visible = true,
  }

  local diff = {
    "diff",
    colored = false,
    symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
    cond = hide_in_width,
  }

  local filetype = {
    "filetype",
    icons_enabled = false,
  }

  local location = {
    "location",
    padding = 0,
  }

  -- Get the current buffer's filetype.
  local get_current_filetype = function()
    return vim.api.nvim_buf_get_option(0, "filetype")
  end

  -- stolen from https://raw.githubusercontent.com/AlexvZyl/.dotfiles/main/.config/nvim/lua/alex/ui/lualine.lua
  local get_native_lsp = function()
    local buf_ft = get_current_filetype()
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
      return "None"
    end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        return client.name
      end
    end
    return "None"
  end

  local spaces = function()
    return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
  end
  lualine.setup {
    options = {
      globalstatus = true,
      icons_enabled = true,
      theme = "auto",
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = { "alpha", "dashboard" },
      always_divide_middle = true,
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch" },
      lualine_c = { diagnostics, diff },
      lualine_x = {
        {
          get_native_lsp,
          icon = {
            " ",
          },
        },
        spaces,
        "encoding",
        filetype,
      },
      lualine_y = { location },
      lualine_z = { "progress" },
    },
  }
end

return M
