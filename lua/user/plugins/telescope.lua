local actions = require "telescope.actions"

return {
  "nvim-telescope/telescope.nvim",
  event = "Bufenter",
  cmd = { "Telescope" },
  opts = {
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
      prompt_prefix = "  ",
      selection_caret = " ",
      border = true,
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
    },
  },
  keys = {
    { "<leader>ff", ":Telescope find_files<CR>", desc = "Telescope find files" },
    { "<leader>fg", ":Telescope live_grep<CR>", desc = "Telescope live grep" },
    { "<leader>fb", ":Telescope buffers<CR>", desc = "Telescop find buffer" },
  },
}
