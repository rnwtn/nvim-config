return {
  "neovim/nvim-lspconfig",
  event = "BufReadPre",
  dependencies = {
    { "b0o/schemastore.nvim" },
    { "j-hui/fidget.nvim" },
    { "kevinhwang91/nvim-ufo", dependencies = "kevinhwang91/promise-async" },
    { "nvim-telescope/telescope.nvim" },
    { "simrat39/rust-tools.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
  },
  config = function()
    local function on_attach(client, bufnr)
      local keymap = vim.keymap.set
      local opts = { buffer = bufnr }
      keymap("n", "<leader>lk", ":lua vim.lsp.buf.signature_help()<CR>", opts)
      keymap("n", "<leader>lr", ":lua vim.lsp.buf.rename()<CR>", opts)
      keymap("n", "<leader>la", ":lua vim.lsp.buf.code_action()<CR>", opts)
      keymap("n", "<leader>ls", ":lua vim.lsp.buf.signature_help()<CR>", opts)
      keymap("n", "<leader>lf", ":lua vim.lsp.buf.format({ async = true })<CR>", opts)
      keymap("n", "K", ":lua vim.lsp.buf.hover()<CR>", opts)
      keymap("n", "gD", ":lua vim.lsp.buf.declaration()<CR>", opts)
      keymap("n", "gd", ":Telescope lsp_definitions show_line=false<cr>", opts)
      keymap("n", "gr", ":Telescope lsp_references show_line=false<cr>", opts)
      keymap("n", "gi", ":Telescope lsp_implementations show_line=false<cr>", opts)
      keymap("n", "go", ":Telescope lsp_document_symbols<CR>", opts)
      keymap("n", "gO", ":Telescope lsp_workspace_symbols<CR>", opts)

      local clients_without_formatting = { "tsserver", "lua_ls" }
      if vim.tbl_contains(clients_without_formatting, client.name) then
        vim.print("Disabling formatting for " .. client.name)
        client.server_capabilities.documentFormattingProvider = false
      end
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    }

    require("mason-lspconfig").setup()
    require("mason-lspconfig").setup_handlers({
      function(server_name) -- default handler
        require("lspconfig")[server_name].setup({
          capabilities = capabilities,
          on_attach = on_attach,
        })
      end,
      ["tsserver"] = function()
        require("lspconfig").tsserver.setup({
          capabilities = capabilities,
          on_attach = on_attach,
          settings = {
            formatting = false,
          },
        })
      end,
      ["lua_ls"] = function()
        require("lspconfig").lua_ls.setup({
          capabilities = capabilities,
          on_attach = on_attach,
          settings = {
            formatting = false,
            Lua = {
              runtime = {
                version = "LuaJIT",
              },
              diagnostics = {
                globals = { "vim" },
              },
              workspace = {
                library = {
                  vim.env.VIMRUNTIME,
                },
              },
            },
          },
        })
      end,
      ["jsonls"] = function()
        require("lspconfig").jsonls.setup({
          capabilities = capabilities,
          on_attach = on_attach,
          settings = {
            json = {
              schemas = require("schemastore").json.schemas(),
            },
          },
          setup = {
            commands = {
              Format = {
                function()
                  vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
                end,
              },
            },
          },
        })
      end,
      ["rust_analyzer"] = function()
        local extension_path = vim.env.HOME .. "/.vscode-oss/extensions/vadimcn.vscode-lldb-1.9.2-universal/"
        local codelldb_path = extension_path .. "adapter/codelldb"
        local liblldb_path = extension_path .. "lldb/lib/liblldb.so"
        local rust_tools = require("rust-tools")
        rust_tools.setup({
          dap = {
            adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
          },
          server = {
            on_attach = function(client, bufnr)
              on_attach(client, bufnr)

              -- Hover actions
              vim.keymap.set("n", "<S-k>", rust_tools.hover_actions.hover_actions, { buffer = bufnr })
              -- Code action groups
              vim.keymap.set("n", "<Leader>la", rust_tools.code_action_group.code_action_group, { buffer = bufnr })
            end,
          },
        })
      end,
    })

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = "rounded",
      title = "hover",
    })
    vim.diagnostic.config({
      float = { border = "rounded" },
    })

    require("lspconfig.ui.windows").default_options.border = "rounded"
    require("ufo").setup()
    require("fidget").setup()

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "lspinfo",
      callback = function()
        local opts = { buffer = true, noremap = true, silent = true }
        vim.keymap.set("n", "<leader>li", ":q<cr>", opts)
      end,
    })
  end,
  keys = {
    { "<leader>li", ":LspInfo<cr>", desc = "LspInfo open" },
    { "<leader>ld", ":lua vim.diagnostic.open_float({ border = 'rounded' })<CR>", desc = "Open diagnostic" },
    {
      "<leader>lq",
      ":lua vim.diagnostic.setloclist()<CR>",
      desc = "Add diagnostics to quickfix list",
    },
    { "g[", ":lua vim.diagnostic.goto_prev({ border = 'rounded' })<CR>", desc = "goto prev diagnostic" },
    { "g]", ":lua vim.diagnostic.goto_next({ border = 'rounded' })<CR>", desc = "goto next diagnostic" },
  },
}
