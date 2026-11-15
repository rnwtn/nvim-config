-- nvim-treesitter `main` branch (the old `master` branch is frozen).
-- `main` only installs parsers/queries; highlighting is started per buffer with
-- vim.treesitter.start(). Requires the `tree-sitter` CLI and a C compiler.
local ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" }

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false, -- does not support lazy-loading
  build = ":TSUpdate",
  config = function()
    local ts = require("nvim-treesitter")
    ts.install(ensure_installed)

    local available = {}
    for _, lang in ipairs(ts.get_available()) do
      available[lang] = true
    end

    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("user_treesitter", { clear = true }),
      callback = function(ev)
        local lang = vim.treesitter.language.get_lang(ev.match)
        if not lang then
          return
        end
        if vim.treesitter.language.add(lang) then
          vim.treesitter.start(ev.buf, lang)
        elseif available[lang] then
          -- auto-install missing parsers, then start highlighting
          ts.install(lang):await(function()
            if vim.api.nvim_buf_is_valid(ev.buf) and vim.treesitter.language.add(lang) then
              vim.treesitter.start(ev.buf, lang)
            end
          end)
        end
      end,
    })
  end,
}
