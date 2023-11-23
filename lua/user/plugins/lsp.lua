return {
  "VonHeikemen/lsp-zero.nvim",
  branch = "v2.x",
  event = "BufRead",
  dependencies = {
    -- LSP Support
    { "neovim/nvim-lspconfig" },             -- Required
    { "williamboman/mason.nvim" },           -- Optional
    { "williamboman/mason-lspconfig.nvim" }, -- Optional

    -- Autocompletion
    { "hrsh7th/nvim-cmp" },     -- Required
    { "hrsh7th/cmp-nvim-lsp" }, -- Required
    { "L3MON4D3/LuaSnip" },     -- Required

    { "nvim-telescope/telescope.nvim" },
    { "RRethy/vim-illuminate" },
    { "j-hui/fidget.nvim",                tag = "legacy" },
    { "jose-elias-alvarez/null-ls.nvim" },
    { "simrat39/rust-tools.nvim" },
    { "b0o/schemastore.nvim" },
  },
  config = function()
    local function on_lsp_attach(client, bufnr)
      if client.name == "tsserver" then
        client.server_capabilities.documentFormattingProvider = false
      end
      if client.name == "sumneko_lua" then
        client.server_capabilities.documentFormattingProvider = false
      end

      local opts = { noremap = true, silent = true }
      local keymap = vim.api.nvim_buf_set_keymap
      keymap(bufnr, "n", "<leader>lk", ":lua vim.lsp.buf.signature_help()<CR>", opts)
      keymap(bufnr, "n", "<leader>lr", ":lua vim.lsp.buf.rename()<CR>", opts)
      keymap(bufnr, "n", "<leader>la", ":lua vim.lsp.buf.code_action()<CR>", opts)
      keymap(bufnr, "n", "<leader>ld", ":lua vim.diagnostic.open_float()<CR>", opts)
      keymap(bufnr, "n", "<leader>fd", ":Telescope diagnostics bufnr=0<CR>", opts)
      keymap(bufnr, "n", "<leader>fD", ":Telescope diagnostics<CR>", opts)
      keymap(bufnr, "n", "<leader>ls", ":lua vim.lsp.buf.signature_help()<CR>", opts)
      keymap(bufnr, "n", "<leader>lq", ":lua vim.diagnostic.setloclist()<CR>", opts)
      keymap(bufnr, "n", "<leader>lf", ":lua vim.lsp.buf.format({ async = true })<CR>", opts)
      keymap(bufnr, "n", "K", ":lua vim.lsp.buf.hover()<CR>", opts)
      keymap(bufnr, "n", "g[", ':lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
      keymap(bufnr, "n", "g]", ':lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
      keymap(bufnr, "n", "gD", ":lua vim.lsp.buf.declaration()<CR>", opts)
      keymap(bufnr, "n", "gd", ":Telescope lsp_definitions show_line=false<cr>", opts)
      keymap(bufnr, "n", "gr", ":Telescope lsp_references show_line=false<cr>", opts)
      keymap(bufnr, "n", "gi", ":Telescope lsp_implementations show_line=false<cr>", opts)
      keymap(bufnr, "n", "go", ":Telescope lsp_document_symbols<CR>", opts)
      keymap(bufnr, "n", "gO", ":Telescope lsp_workspace_symbols<CR>", opts)

      require("illuminate").on_attach(client)
    end

    local function configure_rust_tools()
      local extension_path = vim.env.HOME .. "/.vscode-oss/extensions/vadimcn.vscode-lldb-1.9.2-universal/"
      local codelldb_path = extension_path .. "adapter/codelldb"
      local liblldb_path = extension_path .. "lldb/lib/liblldb.so"
      local rust_tools = require "rust-tools"
      rust_tools.setup {
        dap = {
          adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
        },
        server = {
          on_attach = function(client, bufnr)
            on_lsp_attach(client, bufnr)

            -- Hover actions
            vim.keymap.set("n", "<S-k>", rust_tools.hover_actions.hover_actions, { buffer = bufnr })
            -- Code action groups
            vim.keymap.set("n", "<Leader>la", rust_tools.code_action_group.code_action_group, { buffer = bufnr })
          end,
        },
      }
    end

    local function configure_lsp_zero()
      local lsp = require("lsp-zero").preset {}
      lsp.on_attach(on_lsp_attach)

      require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())
      require("lspconfig").jsonls.setup {
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
          },
        },
        setup = {
          commands = {
            Format = {
              function()
                vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line "$", 0 })
              end,
            },
          },
        },
      }

      lsp.skip_server_setup { "rust_analyzer" }
      lsp.setup()
      vim.diagnostic.config { virtual_text = false }

      require("lspconfig.ui.windows").default_options.border = "rounded"
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "lspinfo",
        callback = function()
          local opts = { buffer = true, noremap = true, silent = true }
          vim.keymap.set("n", "<leader>li", ":q<cr>", opts)
        end,
      })
    end

    configure_lsp_zero()
    configure_rust_tools()
    require("fidget").setup {}
  end,
  keys = {
    { "<leader>li", ":LspInfo<cr>", desc = "LspInfo open" },
  },
}
