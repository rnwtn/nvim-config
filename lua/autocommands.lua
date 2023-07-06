vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "qf", "help", "man", "lspinfo", "spectre_panel" },
  callback = function()
    vim.cmd [[
      nnoremap <silent> <buffer> q :close<CR>
      set nobuflisted
    ]]
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

vim.api.nvim_create_autocmd({ "VimResized" }, {
  callback = function()
    vim.cmd "tabdo wincmd ="
  end,
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function()
    vim.highlight.on_yank { higroup = "Visual", timeout = 200 }
  end,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "*.java" },
  callback = function()
    vim.lsp.codelens.refresh()
  end,
})

vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function()
    vim.cmd "hi link illuminatedWord LspReferenceText"
  end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  callback = function()
    local line_count = vim.api.nvim_buf_line_count(0)
    if line_count >= 5000 then
      vim.cmd "IlluminatePauseBuf"
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "harpoon",
  callback = function(ev)
    local opts = { buffer = true, noremap = true, silent = true }
    vim.keymap.set("n", "x", "", opts)
    vim.keymap.set("n", "c", "", opts)
    vim.keymap.set("n", "s", "", opts)
    -- Open harpooned files in vsplit with <C-V>
    vim.keymap.set("n", "<C-V>", function()
      local curline = vim.api.nvim_get_current_line()
      local working_directory = vim.fn.getcwd() .. "/"
      vim.cmd "vs"
      vim.cmd("e " .. working_directory .. curline)
    end, opts)
  end,
})
