vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function()
    vim.highlight.on_yank { higroup = "Visual", timeout = 200 }
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
    local harpoon_opts = { buffer = true, noremap = true, silent = true }
    vim.keymap.set("n", "x", "", harpoon_opts)
    vim.keymap.set("n", "c", "", harpoon_opts)
    vim.keymap.set("n", "s", "", harpoon_opts)
    -- Open harpooned files in vsplit with <C-V>
    vim.keymap.set("n", "<C-V>", function()
      local curline = vim.api.nvim_get_current_line()
      local working_directory = vim.fn.getcwd() .. "/"
      vim.cmd "vs"
      vim.cmd("e " .. working_directory .. curline)
    end, harpoon_opts)
  end,
})
