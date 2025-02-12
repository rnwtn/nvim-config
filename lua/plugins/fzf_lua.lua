return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    winopts = {
      border = "single", -- :h nvim_open_win()
      backdrop = 100,
      preview = {
        layout = "vertical",
        border = "single", -- :h nvim_open_win()
      },
    },
    keymap = {
      builtin = {
        ["<C-d>"] = "preview-page-down",
        ["<C-u>"] = "preview-page-up",
      },
    },
  },
  keys = {
    { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "find files" },
    { "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "find open buffers" },
    { "<leader>fg", "<cmd>FzfLua grep_visual<cr>", desc = "live grep" },
    { "<leader>fw", "<cmd>FzfLua grep_cword<cr>", desc = "grep word under cursor" },
    { "<leader>fW", "<cmd>FzfLua grep_cWORD<cr>", desc = "grep WORD under cursor" },
    { "<leader>fc", "<cmd>FzfLua colorschemes<cr>", desc = "change colorscheme" },
    { "<leader>fh", "<cmd>FzfLua helptags<cr>", desc = "find help" },
  },
}
