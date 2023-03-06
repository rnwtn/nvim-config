-- Define some symbols for diagnostic information
vim.fn.sign_define("DiagnosticSignError",
  { text = " ", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn",
  { text = " ", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo",
  { text = " ", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint",
  { text = "", texthl = "DiagnosticSignHint" })

local lsp_on_attach = function(client, bufnr)
  -- Update Capabilities
  -- Example: Disable formatting for tsserver
  --if client.name == "tsserver" then
  --  client.server_capabilities.document_formatting = false
  --end

  -- Keymaps
  local bufkeymap = vim.api.nvim_buf_set_keymap
  local opts = { noremap = true, silent = true }
  bufkeymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  bufkeymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  bufkeymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  bufkeymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  bufkeymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  bufkeymap(bufnr, "n", "<leader>lk", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  bufkeymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  bufkeymap(bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  bufkeymap(bufnr, "n", "<leader>ld", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  bufkeymap(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
  bufkeymap(bufnr, "n", "<leader>l[", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
  bufkeymap(bufnr, "n", "<leader>l]", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
  bufkeymap(bufnr, "n", "<leader>lf", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts)
  bufkeymap(bufnr, "n", "<leader>lo", "<cmd>SymbolsOutline<CR>", opts)

  -- use Telescope for definitions and references
  local has_telescope, _ = pcall(require, "telescope")
  if has_telescope then
    bufkeymap(bufnr, "n", "gd", ":Telescope lsp_definitions<cr>", opts)
    bufkeymap(bufnr, "n", "gr", ":Telescope lsp_references<cr>", opts)
    bufkeymap(bufnr, "n", "gi", ":Telescope lsp_implementations<cr>", opts)
  end

  -- overwrite some keymappings for rust-tools
  if client.name == "rust_analyzer" then
    local rust_tools = require("rust-tools")
    vim.keymap.set("n", "K", rust_tools.hover_actions.hover_actions, { buffer = bufnr })
    vim.keymap.set("n", "<Leader>la", rust_tools.code_action_group.code_action_group, { buffer = bufnr })
  end

  -- add format command
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

require("mason").setup({
  ui = {
    border = "rounded", -- Accepts same border values as |nvim_open_win()|
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

require("mason-lspconfig").setup({
  ensure_installed = { "sumneko_lua", "rust_analyzer" },
})

require("mason-lspconfig").setup_handlers {
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup {
      on_attach = lsp_on_attach,
    }
  end,
  -- Next, you can provide a dedicated handler for specific servers.
  -- For example, a handler override for the `rust_analyzer`:
  ["rust_analyzer"] = function()
    require("rust-tools").setup {
      single_file_support = false,
      server = {
        on_attach = lsp_on_attach,
      }
    }
  end,
  ["sumneko_lua"] = function()
    require('lspconfig').sumneko_lua.setup {
      on_attach = lsp_on_attach,
      settings = {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT',
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = { 'vim' },
          },
          -- workspace = {
          --   -- Make the server aware of Neovim runtime files
          --   library = vim.api.nvim_get_runtime_file("", true),
          -- },
          -- Do not send telemetry data containing a randomized but unique identifier
          telemetry = {
            enable = false,
          },
        },
      },
    }
  end
}

-- Gives status updates in the lower-right corner as the lsp is being configured
require("fidget").setup()

if true then return end

-- Setup null-ls
require("mason-null-ls").setup({
  automatic_setup = true,
})
