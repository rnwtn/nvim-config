return {
  src = "https://github.com/ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("fzf-lua").setup({
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
    })

    -- vim.cmd([[FzfLua register_ui_select]])
    vim.keymap.set("n", "<leader>ff", "<cmd>FzfLua files<cr>");
    vim.keymap.set("n", "<leader>fb", "<cmd>FzfLua buffers<cr>");
    vim.keymap.set("n", "<leader>fg", "<cmd>FzfLua live_grep<cr>");
    vim.keymap.set("n", "<leader>fg", "<cmd>FzfLua grep_visual<cr>");
    vim.keymap.set("n", "<leader>fw", "<cmd>FzfLua grep_cword<cr>");
    vim.keymap.set("n", "<leader>fW", "<cmd>FzfLua grep_cWORD<cr>");
    vim.keymap.set("n", "<leader>fc", "<cmd>FzfLua colorschemes<cr>");
    vim.keymap.set("n", "<leader>fh", "<cmd>FzfLua helptags<cr>");
  end,
}
