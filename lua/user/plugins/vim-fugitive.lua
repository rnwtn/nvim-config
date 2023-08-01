return {
  "tpope/vim-fugitive",
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    -- {
    --   "<leader>gs",
    --   function()
    --     vim.cmd "tabnew"
    --     vim.cmd "Git"
    --     vim.cmd ":only"
    --   end,
    --   desc = "Git open Vim-Fugitive",
    -- },
    { "<leader>gs", ":Git<cr>",        desc = "Git open Vim-Fugitive" },
    { "<leader>gp", ":Git pull<cr>",   desc = "Git pull" },
    { "<leader>gP", ":Git push<cr>",   desc = "Git push" },
    { "<leader>gc", ":Git commit<cr>", desc = "Git push" },
  },
}
