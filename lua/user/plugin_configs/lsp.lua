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
  local keymaps = require("user.keymaps")
  keymaps.lsp(bufnr)

  -- use Telescope for definitions and references
  local has_telescope, _ = pcall(require, "telescope")
  if has_telescope then
    keymaps.lsp_telescope(bufnr)
  end

  -- use nvim-code-action-menu for code actions
  -- local has_code_action_menu, _ = pcall(require, "nvim-code-action-menu")
  -- if has_code_action_menu then
  --   keymaps.lsp_code_action_menu(bufnr)
  -- end

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

require("neodev").setup({ -- Setup neodev before the lus_ls server
  library = { plugins = { "nvim-dap-ui" }, types = true },
})
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "rust_analyzer", --[[ "texlab" ]] },
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
      },
      dap = {
        adapter = require('rust-tools.dap').get_codelldb_adapter(
          "codelldb",
          vim.fn.expand("~/.local/share/nvim/mason/packages/codelldb/extension/lldb/lib/liblldb.so")
        )
      }
    }
  end,
  -- ["lua_ls"] = function()
  --   require('lspconfig').lua_ls.setup {
  --       on_attach = lsp_on_attach,
  --       settings = {
  --           Lua = {
  --               runtime = {
  --                   -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
  --                   version = 'LuaJIT',
  --               },
  --               diagnostics = {
  --                   -- Get the language server to recognize the `vim` global
  --                   globals = { 'vim' },
  --               },
  --               -- workspace = {
  --               --   -- Make the server aware of Neovim runtime files
  --               --   library = vim.api.nvim_get_runtime_file("", true),
  --               -- },
  --               -- Do not send telemetry data containing a randomized but unique identifier
  --               telemetry = {
  --                   enable = false,
  --               },
  --           },
  --       },
  --   }
  -- end
}

vim.g.code_action_menu_window_border = 'single'
-- vim.g.code_action_menu_show_details = false
-- vim.g.code_action_menu_show_diff = false
-- vim.g.code_action_menu_show_action_kind = false

-- Gives status updates in the lower-right corner as the lsp is being configured
require("fidget").setup()

-- Setup null-ls
require("mason-null-ls").setup({
  ensure_installed = {
    -- Opt to list sources here, when available in mason.
  },
  automatic_installation = false,
  automatic_setup = true, -- Recommended, but optional
})
require("null-ls").setup {
  sources = {
    -- Anything not supported by mason.
  }
}
require 'mason-null-ls'.setup_handlers() -- If `automatic_setup` is true.
