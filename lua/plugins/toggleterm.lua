return {
  "akinsho/toggleterm.nvim",
  event = "VeryLazy",
  config = function()
    local toggleterm = require("toggleterm")
    toggleterm.setup({
      size = 20,
      open_mapping = [[<c-\>]],
      hide_numbers = true,
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = "float",
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = "single",
      },
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "toggleterm",
      callback = function()
        local opts = { buffer = true, noremap = true, silent = true }
        vim.keymap.set("n", "q", ":q<cr>", opts)
      end,
    })
  end,
}
