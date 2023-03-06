vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = { "*.tex" },
  callback = function(ev)
    require("user.keymaps").ft_latex(ev.buf)
  end
})
