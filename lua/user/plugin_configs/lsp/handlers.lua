local M = {}

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = require("cmp_nvim_lsp").default_capabilities(M.capabilities)

M.setup = function()
  require("mason").setup({
    ui = {
      border = "none", -- Accepts same border values as |nvim_open_win()|
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗"
      }
    },
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 4,
  })

  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn",  text = "" },
    { name = "DiagnosticSignHint",  text = "" },
    { name = "DiagnosticSignInfo",  text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    -- disable virtual text
    virtual_text = false,
    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })

  vim.g.code_action_menu_window_border = 'single'
  -- vim.g.code_action_menu_show_details = false
  -- vim.g.code_action_menu_show_diff = false
  -- vim.g.code_action_menu_show_action_kind = false

  -- Gives status updates in the lower-right corner as the lsp is being configured
  require("fidget").setup()
end

local function lsp_highlight_document(client)
  -- Set autocommands conditional on server_capabilities
  print(vim.inspect(client.server_capabilities));
  if client.server_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
      false
    )
  end
end

local function lsp_keymaps(client, bufnr)
  local keymaps = require("user.keymaps")
  keymaps.lsp(bufnr)

  -- use Telescope for definitions and references
  local has_telescope, _ = pcall(require, "telescope")
  if has_telescope then
    keymaps.lsp_telescope(bufnr)
  end

  -- overwrite some keymappings for rust-tools
  if client.name == "rust_analyzer" then
    keymaps.lsp_rust_tools(bufnr)
  end

  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
  -- add format command
end

M.on_attach = function(client, bufnr)
  if client.name == "tsserver" then
    client.server_capabilities.document_formatting = false
  end
  lsp_keymaps(client, bufnr)
  lsp_highlight_document(client)
end

return M
