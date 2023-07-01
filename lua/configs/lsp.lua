return {
  "neovim/nvim-lspconfig",
  lazy = true,
  dependencies = {
    {
      "hrsh7th/cmp-nvim-lsp",
      "nvim-telescope/telescope.nvim",
      "simrat39/rust-tools.nvim", -- Better rust language support (Rust)
      "b0o/schemastore.nvim", -- Schemas for jsonls (JSON)
    },
    {
      "utilyre/barbecue.nvim",
      name = "barbecue",
      version = "*",
      dependencies = {
        "SmiteshP/nvim-navic",
        "nvim-tree/nvim-web-devicons", -- optional dependency
      },
    },
    {
      "j-hui/fidget.nvim",
      tag = "legacy",
    },
  },
  config = function()
    local cmp_nvim_lsp = require "cmp_nvim_lsp"
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

    local function lsp_keymaps(bufnr)
      local opts = { noremap = true, silent = true }
      local keymap = vim.api.nvim_buf_set_keymap
      keymap(bufnr, "n", "<leader>li", "<cmd>LspInfo<cr>", opts)
      keymap(bufnr, "n", "<leader>lI", "<cmd>Mason<cr>", opts)
      keymap(bufnr, "n", "<leader>lk", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
      keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
      keymap(bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
      keymap(bufnr, "n", "<leader>ld", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
      keymap(bufnr, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
      keymap(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
      keymap(bufnr, "n", "<leader>lf", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts)
      keymap(bufnr, "n", "K", ":lua vim.lsp.buf.hover()<CR>", opts)
      keymap(bufnr, "n", "g[", ':lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
      keymap(bufnr, "n", "g]", ':lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
      keymap(bufnr, "n", "gD", ":lua vim.lsp.buf.declaration()<CR>", opts)
      keymap(bufnr, "n", "gd", ":Telescope lsp_definitions<cr>", opts)
      keymap(bufnr, "n", "gr", ":Telescope lsp_references<cr>", opts)
      keymap(bufnr, "n", "gi", ":Telescope lsp_implementations<cr>", opts)
      keymap(bufnr, "n", "go", ":Telescope lsp_document_symbols<CR>", opts)
      keymap(bufnr, "n", "gO", ":Telescope lsp_workspace_symbols<CR>", opts)
    end

    local lspconfig = require "lspconfig"
    local on_attach = function(client, bufnr)
      if client.name == "tsserver" then
        client.server_capabilities.documentFormattingProvider = false
      end

      if client.name == "sumneko_lua" then
        client.server_capabilities.documentFormattingProvider = false
      end

      lsp_keymaps(bufnr)
      require("illuminate").on_attach(client)
    end

    for _, server in pairs(require("utils").servers) do
      Opts = {
        on_attach = on_attach,
        capabilities = capabilities,
      }

      server = vim.split(server, "@")[1]

      local require_ok, conf_opts = pcall(require, "settings." .. server)
      if require_ok then
        Opts = vim.tbl_deep_extend("force", conf_opts, Opts)
      end

      lspconfig[server].setup(Opts)
    end

    local signs = {
      { name = "DiagnosticSignError", text = "" },
      { name = "DiagnosticSignWarn", text = "" },
      { name = "DiagnosticSignHint", text = "" },
      { name = "DiagnosticSignInfo", text = "" },
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
        suffix = "",
      },
    }

    vim.diagnostic.config(config)

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = "rounded",
    })

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
      border = "rounded",
    })

    -- rust-tools setup --
    local extension_path = vim.env.HOME .. "/.vscode-oss/extensions/vadimcn.vscode-lldb-1.9.2-universal/"
    local codelldb_path = extension_path .. "adapter/codelldb"
    local liblldb_path = extension_path .. "lldb/lib/liblldb.so"
    local rt = require "rust-tools"
    rt.setup {
      dap = {
        adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
      },

      server = {
        on_attach = function(client, bufnr)
          on_attach(client, bufnr)

          -- Hover actions
          vim.keymap.set("n", "<S-k>", rt.hover_actions.hover_actions, { buffer = bufnr })
          -- Code action groups
          vim.keymap.set("n", "<Leader>la", rt.code_action_group.code_action_group, { buffer = bufnr })
        end,
      },
    }

    require("fidget").setup {}
    require("barbecue").setup {}
  end,
}
