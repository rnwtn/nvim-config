-- Formatting (replaces none-ls). Formatting is manual via <leader>lf, as before.
local prettier = { "prettier" }
-- Biome when the project has a biome.json(c), otherwise prettier
local biome_or_prettier = { "biome", "prettier", stop_after_first = true }

return {
  "stevearc/conform.nvim",
  cmd = "ConformInfo",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "black" },
      gdscript = { "gdformat" },
      cs = { "csharpier" },
      javascript = biome_or_prettier,
      javascriptreact = biome_or_prettier,
      typescript = biome_or_prettier,
      typescriptreact = biome_or_prettier,
      vue = prettier,
      svelte = prettier,
      astro = prettier,
      css = biome_or_prettier,
      scss = prettier,
      less = prettier,
      html = prettier,
      json = biome_or_prettier,
      jsonc = biome_or_prettier,
      yaml = prettier,
      markdown = prettier,
      graphql = biome_or_prettier,
      handlebars = prettier,
      toml = prettier, -- needs prettier-plugin-toml in the project
    },
    formatters = {
      -- only treat biome as available inside a project with a biome config
      biome = { require_cwd = true },
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
