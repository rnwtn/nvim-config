local cmd = vim.lsp.rpc.connect("127.0.0.1", 6005)

vim.lsp.start({
  name = "Godot",
  cmd = cmd,
  root_dir = vim.fs.dirname(vim.fs.find({ "project.godot", ".git" }, { upward = true })[1]),
  on_attach = function()
    vim.notify("Connected to Godot LSP")
  end,
  on_error = function(_, err)
    vim.notify(err, vim.log.levels.ERROR)
  end,
})

-- tabs are rendered as 4 spaces
vim.opt.tabstop = 4
