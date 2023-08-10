return {
  "folke/trouble.nvim",
  event = "LspAttach",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("trouble").setup({})
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "Trouble",
      callback = function()
        local opts = { buffer = true, noremap = true, silent = true }
        vim.keymap.set("n", "<leader>lD", ":q<cr>", opts)
      end,
    })
  end,
  keys = {
    { "<leader>lD", ":Trouble<cr>", desc = "Trouble toggle"}
  }
}
