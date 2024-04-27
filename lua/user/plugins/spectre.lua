return {
  "nvim-pack/nvim-spectre",
  event = "BufReadPost",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {},
  keys = {
    { "<leader>rr", ":lua require('spectre').open_file_search()<cr>", desc = "Spectre toggle" },
    { "<leader>rR", ":lua require('spectre').toggle()<cr>", desc = "Spectre toggle" },
    {
      "<leader>rw",
      ":lua require('spectre').open_file_search({select_word=true})<cr>",
      desc = "Spectre search word under cursor in file",
    },
    {
      "<leader>rW",
      ":lua require('spectre').open_visual({select_word=true})<cr>",
      desc = "Spectre search word under cursor in cwd",
    },
  },
}
