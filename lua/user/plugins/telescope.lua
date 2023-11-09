local actions = require "telescope.actions"

return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-telescope/telescope-ui-select.nvim" },
  event = "Bufenter",
  cmd = { "Telescope" },
  config = function()
    require("telescope").setup {
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown {
            -- even more opts
          },

          -- pseudo code / specification for writing custom displays, like the one
          -- for "codeactions"
          -- specific_opts = {
          --   [kind] = {
          --     make_indexed = function(items) -> indexed_items, width,
          --     make_displayer = function(widths) -> displayer
          --     make_display = function(displayer) -> function(e)
          --     make_ordinal = function(e) -> string
          --   },
          --   -- for example to disable the custom builtin "codeactions" display
          --      do the following
          --   codeactions = false,
          -- }
        },
      },
      defaults = {
        file_ignore_patterns = {
          ".git/",
          ".svelte%-kit/",
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
        -- path_display = { "truncate" },
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          height = 0.95,
          horizontal = {
            prompt_position = "top",
            mirror = false,
            -- preview_cutoff = 0,
          },
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
    }
    require("telescope").load_extension "ui-select"
  end,
  keys = {
    { "<leader>ff", ":Telescope find_files hidden=true<CR>", desc = "Telescope find files" },
    { "<C-p>",      ":Telescope git_files<CR>",              desc = "Telescope git files" },
    { "<leader>fg", ":Telescope live_grep<CR>",              desc = "Telescope live grep" },
    { "<leader>fw", ":Telescope grep_string<CR>",            desc = "Telescope grep string" },
    { "<leader>fb", ":Telescope buffers<CR>",                desc = "Telescop find buffer" },
  },
}
