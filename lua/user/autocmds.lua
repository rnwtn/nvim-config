vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "qf" },
  callback = function()
    vim.opt_local.relativenumber = false
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "help", "lazy", "spectre_panel" },
  callback = function()
    local opts = { buffer = true, noremap = true, silent = true }
    vim.keymap.set("n", "q", ":q<cr>", opts)
  end,
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
  end,
})
