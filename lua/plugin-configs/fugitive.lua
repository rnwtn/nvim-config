return {
  src = "https://github.com/tpope/vim-fugitive",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "fugitive",
      callback = function()
        local opts = { buffer = true, noremap = true, silent = true }
        vim.keymap.set("n", "<leader>gs", ":q<cr>", opts)
        vim.keymap.set("n", "q", ":q<cr>", opts)
      end,
    })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "gitcommit",
      callback = function()
        local opts = { buffer = true, noremap = true, silent = true }
        vim.keymap.set("n", "q", ":q!<cr>", opts)
        vim.keymap.set("n", "<leader>gc", ":q!<cr>", opts)
        -- vim.cmd "startinsert"
      end,
    })
    vim.keymap.set("n", "<leader>gs", ":Git<cr>");
    vim.keymap.set("n", "<leader>gp", ":Git pull<cr>");
    vim.keymap.set("n", "<leader>gP", ":Git push<cr>");
    vim.keymap.set("n", "<leader>gc", ":Git commit<cr>");
  end,
}
