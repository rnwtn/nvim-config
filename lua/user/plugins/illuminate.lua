return {
  "RRethy/vim-illuminate",
  event = "VeryLazy",
  config = function()
    require("illuminate").configure {
      filetypes_denylist = {
        "Trouble",
        "lir",
        "qf",
        "toggleterm",
        "gitcommit",
        "oil",
        "harpoon",
        "TelescopePrompt",
      },
    }
    vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
      callback = function()
        local line_count = vim.api.nvim_buf_line_count(0)
        if line_count >= 5000 then
          vim.cmd "IlluminatePauseBuf"
        end
      end,
    })
  end,
  keys = {
    {
      "<a-n>",
      ':lua require"illuminate".next_reference{wrap=true}<cr>',
      desc = "Illuminate navigate next",
    },
    {
      "<a-p>",
      ':lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>',
      desc = "Illuminate navigate prev",
    },
  },
}
