-- Formatting (replaces none-ls). Formatting is manual via <leader>lf, as before.
local prettier = { "prettier" }

return {
  "stevearc/conform.nvim",
  cmd = "ConformInfo",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "black" },
      gdscript = { "gdformat" },
      cs = { "csharpier" },
      javascript = prettier,
      javascriptreact = prettier,
      typescript = prettier,
      typescriptreact = prettier,
      vue = prettier,
      svelte = prettier,
      astro = prettier,
      css = prettier,
      scss = prettier,
      less = prettier,
      html = prettier,
      json = prettier,
      jsonc = prettier,
      yaml = prettier,
      markdown = prettier,
      graphql = prettier,
      handlebars = prettier,
      toml = prettier, -- needs prettier-plugin-toml in the project
    },
    -- fall back to the LSP formatter for filetypes not listed above
    default_format_opts = {
      lsp_format = "fallback",
      timeout_ms = 2000,
    },
  },
  keys = {
    {
      "<leader>lf",
      function()
        require("conform").format()
      end,
      mode = { "n", "x" },
      desc = "Format buffer / selection",
    },
  },
}
