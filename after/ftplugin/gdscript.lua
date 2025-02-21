local cmd = vim.lsp.rpc.connect("127.0.0.1", 6005)

vim.lsp.start({
  name = "Godot",
  cmd = cmd,
  root_dir = vim.fs.dirname(vim.fs.find({ "project.godot", ".git" }, { upward = true })[1]),
  on_attach = function(client, bufnr)
    -- vim.notify("Connected to Godot LSP")
  end,
})
