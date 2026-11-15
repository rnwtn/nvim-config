return {
  "mrcjkb/rustaceanvim",
  version = "^9",
  lazy = false, -- the plugin lazy-loads itself on rust files
  init = function()
    ---@type rustaceanvim.Opts
    vim.g.rustaceanvim = {
      tools = {
        float_win_config = {
          border = "single",
        },
      },
      -- codelldb is detected automatically if it is on PATH (e.g. `:MasonInstall codelldb`).
      -- Debugging also requires nvim-dap.
      server = {
        on_attach = function(_, bufnr)
          vim.keymap.set("n", "<leader>la", function()
            vim.cmd.RustLsp("codeAction")
          end, { desc = "Code Action", buffer = bufnr })
          vim.keymap.set("n", "<leader>dr", function()
            vim.cmd.RustLsp("debuggables")
          end, { desc = "Rust Debuggables", buffer = bufnr })
        end,
        default_settings = {
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
              buildScripts = {
                enable = true,
              },
            },
            checkOnSave = true,
            diagnostics = {
              enable = true,
            },
            procMacro = {
              enable = true,
              ignored = {
                ["async-trait"] = { "async_trait" },
                ["napi-derive"] = { "napi" },
                ["async-recursion"] = { "async_recursion" },
              },
            },
            files = {
              exclude = {
                ".direnv",
                ".git",
                ".github",
                ".gitlab",
                "bin",
                "node_modules",
                "target",
                "venv",
                ".venv",
              },
            },
          },
        },
      },
    }
  end,
}
