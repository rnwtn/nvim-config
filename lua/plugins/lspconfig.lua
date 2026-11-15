-- LSP setup for Neovim 0.11+.
--
-- nvim-lspconfig now only ships server configs (lsp/<name>.lua); Neovim itself
-- does the rest through vim.lsp.config() and vim.lsp.enable().
-- mason-lspconfig calls vim.lsp.enable() for every server installed via Mason.
--
-- Servers managed elsewhere:
--   rust-analyzer -> rustaceanvim (lua/plugins/rustacean.lua)
--   roslyn (C#)   -> roslyn.nvim  (lua/plugins/csharp.lua)
return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "mason-org/mason.nvim",
    "mason-org/mason-lspconfig.nvim",
    "b0o/schemastore.nvim",
    "saghen/blink.cmp",
  },
  config = function()
    -- Defaults for every server
    vim.lsp.config("*", {
      capabilities = require("blink.cmp").get_lsp_capabilities(),
    })

    vim.lsp.config("jsonls", {
      settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
      },
    })

    vim.lsp.config("tailwindcss", {
      filetypes = {
        "html",
        "css",
        "scss",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "svelte",
        "vue",
      },
      settings = {
        tailwindCSS = {
          experimental = {
            classRegex = { { "tv\\(([^)]*)\\)", "{?\\s?[\\w].*:\\s*?[\"'`]([^\"'`]*).*?,?\\s?}?" } },
          },
          includeLanguages = {
            svelte = "html",
          },
          lint = {
            cssConflict = "warning",
            invalidApply = "error",
            invalidConfigPath = "error",
            invalidScreen = "error",
            invalidTailwindDirective = "error",
            invalidVariant = "error",
            recommendedVariantOrder = "warning",
          },
          validate = true,
        },
      },
    })

    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "jsonls",
        "ts_ls",
        "tailwindcss",
        "eslint", -- replaces eslint_d code actions from none-ls
      },
      automatic_enable = {
        exclude = {
          "rust_analyzer", -- handled by rustaceanvim
          "stylua", -- stylua has an LSP mode now; conform already runs it
        },
      },
    })

    -- Godot editor's built-in LSP (TCP 127.0.0.1:6005); not installed via Mason
    vim.lsp.enable("gdscript")

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("user_lsp_attach", { clear = true }),
      callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client then
          vim.notify("LSP Connected: " .. client.name)
        end
      end,
    })

    vim.diagnostic.config({
      virtual_text = true, -- off by default since Neovim 0.11
      float = { border = "single" },
    })

    vim.api.nvim_create_user_command("DiagnosticsToggleVirtualText", function()
      local current_value = vim.diagnostic.config().virtual_text
      vim.diagnostic.config({ virtual_text = not current_value })
    end, {})

    vim.api.nvim_create_user_command("DiagnosticsToggle", function()
      vim.diagnostic.enable(not vim.diagnostic.is_enabled())
    end, {})
  end,
  keys = {
    { "K", vim.lsp.buf.hover, desc = "LSP Hover" },
    { "gD", vim.lsp.buf.declaration, desc = "LSP goto declaration" },
    { "gd", "<cmd>FzfLua lsp_definitions<cr>", desc = "LSP goto definition" },
    { "gr", "<cmd>FzfLua lsp_references<cr>", desc = "LSP goto references" },
    { "gi", "<cmd>FzfLua lsp_implementations<cr>", desc = "LSP goto implementations" },
    { "go", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "LSP find document symbols" },
    { "gO", "<cmd>FzfLua lsp_workspace_symbols<cr>", desc = "LSP find workspace symbols" },
    {
      "g[",
      function()
        vim.diagnostic.jump({ count = -1, float = true })
      end,
      desc = "goto prev diagnostic",
    },
    {
      "g]",
      function()
        vim.diagnostic.jump({ count = 1, float = true })
      end,
      desc = "goto next diagnostic",
    },
    { "<leader>li", "<cmd>checkhealth vim.lsp<cr>", desc = "LSP information" },
    { "<leader>lr", vim.lsp.buf.rename, desc = "LSP symbol rename" },
    { "<leader>ls", vim.lsp.buf.signature_help, desc = "LSP signature help" },
    { "<leader>lk", vim.lsp.buf.signature_help, desc = "LSP signature help" },
    { "<leader>ld", vim.diagnostic.open_float, desc = "LSP line diagnostics" },
    { "<leader>lD", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "LSP Workspace diagnostics" },
    { "<leader>lq", vim.diagnostic.setloclist, desc = "Quickfix diagnostics" },
    { "<leader>la", "<cmd>FzfLua lsp_code_actions<cr>", desc = "LSP code actions" },
    { "<leader>ltl", "<cmd>DiagnosticsToggleVirtualText<cr>", desc = "LSP toggle inline diagnostics" },
    { "<leader>ltd", "<cmd>DiagnosticsToggle<cr>", desc = "LSP toggle diagnostics" },
    -- <leader>lf (format) lives in conform.lua
  },
}
