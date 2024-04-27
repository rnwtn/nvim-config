return {
  "VonHeikemen/lsp-zero.nvim",
  branch = "v2.x",
  event = "BufRead",
  dependencies = {
    -- LSP Support
    { "neovim/nvim-lspconfig" }, -- Required
    { "williamboman/mason.nvim" }, -- Optional
    { "williamboman/mason-lspconfig.nvim" }, -- Optional

    -- Autocompletion
    { "hrsh7th/nvim-cmp" }, -- Required
    { "hrsh7th/cmp-nvim-lsp" }, -- Required
    { "L3MON4D3/LuaSnip" }, -- Required

    { "kevinhwang91/nvim-ufo", dependencies = "kevinhwang91/promise-async" },
    { "nvim-telescope/telescope.nvim" },
    { "RRethy/vim-illuminate" },
    { "j-hui/fidget.nvim", tag = "legacy" },
    { "nvimtools/none-ls.nvim" },
    { "simrat39/rust-tools.nvim" },
    { "b0o/schemastore.nvim" },
  },
  config = function()
    local is_nuxt_project = false
    local dirList = vim.fn.systemlist("ls -a")
    local original_definition = vim.lsp.buf.definition
    local function nuxt_goto()
      original_definition()
      for _, dirname in ipairs(dirList) do
        if dirname == ".nuxt" then
          is_nuxt_project = true
        end
      end

      if not is_nuxt_project then
        return
      end
      vim.defer_fn(function()
        local line = vim.fn.getline(".")
        local path = string.match(line, '".-/(.-)"')
        local file = vim.fn.expand("%")
        if string.find(path, "index") then
          path = path .. ".ts"
        end

        if string.find(file, "components.d.ts") then
          vim.cmd("bdelete")
          vim.cmd("edit " .. path)
        end
      end, 100)
    end

    local function on_lsp_attach(client, bufnr)
      local keymap = vim.keymap.set
      local opts = { noremap = true, silent = true, buffer = bufnr }
      keymap("n", "<leader>lk", ":lua vim.lsp.buf.signature_help()<CR>", opts)
      keymap("n", "<leader>lr", ":lua vim.lsp.buf.rename()<CR>", opts)
      keymap("n", "<leader>la", ":lua vim.lsp.buf.code_action()<CR>", opts)
      keymap("n", "<leader>ld", ":lua vim.diagnostic.open_float()<CR>", opts)
      keymap("n", "<leader>fd", ":Telescope diagnostics bufnr=0<CR>", opts)
      keymap("n", "<leader>fD", ":Telescope diagnostics<CR>", opts)
      keymap("n", "<leader>ls", ":lua vim.lsp.buf.signature_help()<CR>", opts)
      keymap("n", "<leader>lq", ":lua vim.diagnostic.setloclist()<CR>", opts)
      keymap("n", "<leader>lf", ":lua vim.lsp.buf.format({ async = true })<CR>", opts)
      keymap("n", "K", ":lua vim.lsp.buf.hover()<CR>", opts)
      keymap("n", "g[", ':lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
      keymap("n", "g]", ':lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
      keymap("n", "gD", ":lua vim.lsp.buf.declaration()<CR>", opts)
      keymap("n", "gd", ":Telescope lsp_definitions show_line=false<cr>", opts)
      keymap("n", "gr", ":Telescope lsp_references show_line=false<cr>", opts)
      keymap("n", "gi", ":Telescope lsp_implementations show_line=false<cr>", opts)
      keymap("n", "go", ":Telescope lsp_document_symbols<CR>", opts)
      keymap("n", "gO", ":Telescope lsp_workspace_symbols<CR>", opts)

      if client.name == "tsserver" then
        client.server_capabilities.documentFormattingProvider = false
      end
      if client.name == "volar" then
        client.server_capabilities.documentFormattingProvider = false
        vim.keymap.del("n", "gi", opts)
        vim.keymap.set("n", "gi", nuxt_goto, opts)
      end
      if client.name == "sumneko_lua" then
        client.server_capabilities.documentFormattingProvider = false
      end

      require("illuminate").on_attach(client)
    end

    local function configure_rust_tools()
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
            on_lsp_attach(client, bufnr)

            -- Hover actions
            vim.keymap.set("n", "<S-k>", rust_tools.hover_actions.hover_actions, { buffer = bufnr })
            -- Code action groups
            vim.keymap.set("n", "<Leader>la", rust_tools.code_action_group.code_action_group, { buffer = bufnr })
          end,
        },
      })
    end

    local function configure_code_folding()
      vim.o.foldcolumn = "0" -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      vim.keymap.set("n", "zR", require("ufo").openAllFolds)
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }
      local language_servers = require("lspconfig").util.available_servers()
      for _, ls in ipairs(language_servers) do
        require("lspconfig")[ls].setup({
          capabilities = capabilities,
          -- you can add other fields for setting up lsp server in this table
        })
      end
      require("ufo").setup()
    end

    local function configure_lsp_zero()
      local lsp = require("lsp-zero").preset({})
      lsp.on_attach(on_lsp_attach)

      require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())
      require("lspconfig").jsonls.setup({
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
      require("lspconfig").lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })
      require("lspconfig").tsserver.setup({
        settings = {
          formatting = false,
        },
      })

      lsp.skip_server_setup({ "rust_analyzer" })
      lsp.setup()
      vim.diagnostic.config({ virtual_text = false })

      require("lspconfig.ui.windows").default_options.border = "rounded"
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "lspinfo",
        callback = function()
          local opts = { buffer = true, noremap = true, silent = true }
          vim.keymap.set("n", "<leader>li", ":q<cr>", opts)
        end,
      })
    end

    configure_code_folding()
    configure_lsp_zero()
    configure_rust_tools()
    require("fidget").setup({})
  end,
  keys = {
    { "<leader>li", ":LspInfo<cr>", desc = "LspInfo open" },
  },
}
