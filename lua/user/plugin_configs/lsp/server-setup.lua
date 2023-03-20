require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "rust_analyzer", --[[ "texlab" ]] },
})
require("neodev").setup({ -- Setup neodev before the lus_ls server
  library = { plugins = { "nvim-dap-ui" }, types = true },
})

local on_attach = require("user.plugin_configs.lsp.handlers").on_attach;
local capabilities = require("user.plugin_configs.lsp.handlers").capabilities;

require('lspconfig').gdscript.setup {
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  }
}
require("mason-lspconfig").setup_handlers {
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server_name) -- default handler (optional)
    local opts = {
      on_attach = on_attach,
      capabilities = capabilities,
    }

    local server = vim.split(server_name, "@")[1]
    local require_ok, conf_opts = pcall(require, "user.plugin_configs.lsp.settings." .. server)
    if require_ok then
      opts = vim.tbl_deep_extend("force", conf_opts, opts)
    end
    require("lspconfig")[server_name].setup(opts)
  end,
  -- Next, you can provide a dedicated handler for specific servers.
  -- For example, a handler override for the `rust_analyzer`:
  ["rust_analyzer"] = function()
    require("rust-tools").setup {
      single_file_support = false,
      server = {
        on_attach = on_attach,
      },
      dap = {
        adapter = require('rust-tools.dap').get_codelldb_adapter(
          "codelldb",
          vim.fn.expand("~/.local/share/nvim/mason/packages/codelldb/extension/lldb/lib/liblldb.so")
        )
      }
    }
  end,
}
