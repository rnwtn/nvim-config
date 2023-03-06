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
  local keymaps = require("core.keymaps")
  keymaps.lsp(bufnr)

  -- use Telescope for definitions and references
  --
  local has_telescope, _ = pcall(require, "telescope")
  if has_telescope then
    keymaps.lsp_telescope(bufnr)
  end

  -- overwrite some keymappings for rust-tools
  if client.name == "rust_analyzer" then
    keymaps.lsp_rust_tools(bufnr)
  end

  -- add format command
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

require("mason").setup({
    ui = {
        border = "none", -- Accepts same border values as |nvim_open_win()|
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

-- Setup null-ls
-- require("mason-null-ls").setup({
--     ensure_installed = {
--         -- Opt to list sources here, when available in mason.
--     },
--     automatic_installation = false,
--     automatic_setup = true, -- Recommended, but optional
-- })
-- require("null-ls").setup{
--     sources = {
--         -- Anything not supported by mason.
--     }
-- }
-- require 'mason-null-ls'.setup_handlers() -- If `automatic_setup` is true.
