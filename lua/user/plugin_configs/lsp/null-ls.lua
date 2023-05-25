-- Setup null-ls
require("mason-null-ls").setup({
  ensure_installed = {
    -- Opt to list sources here, when available in mason.
  },
  automatic_installation = false,
  automatic_setup = true, -- Recommended, but optional
})
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = require("null-ls").builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
-- local diagnostics = null_ls.builtins.diagnostics
require("null-ls").setup {
  sources = {
    -- Anything not supported by mason.
    formatting.prettier, --.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
    -- formatting.black.with({ extra_args = { "--fast" } }),
    formatting.stylua,
    formatting.csharpier,
  }
}
-- require 'mason-null-ls'.setup_handlers() -- If `automatic_setup` is true.
