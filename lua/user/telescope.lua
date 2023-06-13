local M = {
  "nvim-telescope/telescope.nvim",
  event = "Bufenter",
  cmd = { "Telescope" },
  dependencies = {
    {
      "ahmedkhalf/project.nvim",
    },
  },
}

local actions = require "telescope.actions"

M.opts = {
  defaults = {
    file_ignore_patterns = {
      ".git/",
      "node_modules/",
      "%.o",
      "%.a",
      "%.out",
      "%.class",
      "%.pdf",
      "%.mkv",
      "%.mp4",
      "%.zip",
    },
    prompt_prefix = " ",
    selection_caret = " ",
    border = true,
    -- borderchars =  { " ", " ", " ", " ", " ", " ", " ", " " },

    path_display = { "truncate" },
    sorting_strategy = "ascending",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
        results_width = 0.8,
      },
      vertical = {
        mirror = false,
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },
    mappings = {
      i = {
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<Tab>"] = actions.move_selection_worse,
        ["<S-Tab>"] = actions.move_selection_better,
      },
      n = {
        ["q"] = actions.close,
        ["<Tab>"] = actions.move_selection_worse,
        ["<S-Tab>"] = actions.move_selection_better,
        ["m"] = actions.toggle_selection + actions.move_selection_worse,
        ["M"] = actions.toggle_selection + actions.move_selection_better,
      },
    },
  }
}

return M
