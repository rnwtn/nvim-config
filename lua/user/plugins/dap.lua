return {
  "mfussenegger/nvim-dap",
  event = "VeryLazy",
  dependencies = {
    "williamboman/mason.nvim",
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
    "mxsdev/nvim-dap-vscode-js",
    "David-Kunz/jester",
    "simrat39/rust-tools.nvim",
  },
  config = function()
    local dap = require "dap"
    local dapui = require "dapui"

    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end

    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end

    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    -- Setup adapters
    -- TODO: make this more automatic by looping over files
    dap.adapters.codelldb = require "user.dap.adapters.codelldb"
    dap.adapters.coreclr = require "user.dap.adapters.coreclr"
    dap.adapters.godot = require "user.dap.adapters.godot"

    require("dap-vscode-js").setup {
      debugger_path = vim.fn.stdpath "data" .. "/mason/packages/js-debug-adapter",
      debugger_cmd = { "js-debug-adapter" },
      adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
    }

    -- Setup default launch configurations
    local codelldb_config = {
      {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
      },
    }
    local node_config = {
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch",
        cwd = "${workspaceFolder}",
        program = "${workspaceFolder}/dist/index.js",
        detached = false,
        skipFiles = { "<node_internals>/**" },
        resolveSourceMapLocations = {
          "${workspaceFolder}/dist/**/*.js",
          "${workspaceFolder}/dist/*.js",
        },
      },
      {
        type = "pwa-node",
        request = "attach",
        name = "Attach",
        cwd = "${workspaceFolder}",
        processId = require("dap.utils").pick_process,
        skipFiles = { "<node_internals>/**" },
        resolveSourceMapLocations = {
          "${workspaceFolder}/dist/**/*.js",
          "${workspaceFolder}/dist/*.js",
        },
      },
    }

    dap.configurations.cs = {
      {
        type = "coreclr",
        name = "launch - netcoredbg",
        request = "launch",
        program = function()
          return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
        end,
      },
    }
    dap.configurations.gdscript = {
      {
        type = "godot",
        request = "launch",
        name = "Launch scene",
        project = "${workspaceFolder}",
        launch_scene = true,
      },
    }

    dap.configurations.cpp = codelldb_config
    dap.configurations.c = codelldb_config
    dap.configurations.rust = codelldb_config
    dap.configurations.typescript = node_config
    dap.configurations.javascript = node_config

    -- Set virtual text when debugging
    require("nvim-dap-virtual-text").setup {}
    require("dapui").setup {
      expand_lines = true,
      icons = { expanded = "", collapsed = "", circular = "" },
      mappings = {
        -- Use a table to apply multiple mappings
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
      },
      floating = {
        max_height = 0.9,
        max_width = 0.5, -- Floats will be treated as percentage of your screen.
        border = vim.g.border_chars, -- Border style. Can be 'single', 'double' or 'rounded'
        mappings = {
          close = { "q", "<Esc>" },
        },
      },
    }

    vim.fn.sign_define("DapStopped", { text = "", texthl = "DiagnosticSignWarn", linehl = "", numhl = "" })
    vim.fn.sign_define("DapBreakpoint", { text = "B", texthl = "DiagnosticSignError", linehl = "", numhl = "" })
    vim.fn.sign_define(
      "DapBreakpointCondition",
      { text = "C", texthl = "DiagnosticSignError", linehl = "", numhl = "" }
    )
    vim.fn.sign_define("DapBreakpointRejected", { text = "R", texthl = "DiagnosticSignError", linehl = "", numhl = "" })
    vim.fn.sign_define("DapLogPoint", { text = "L", texthl = "DiagnosticSignError", linehl = "", numhl = "" })
  end,
  keys = {
    { "<leader>du", ":lua require('dapui').toggle({ reset = true })<cr>" },
    { "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>" },
    { "<leader>db", ":DapToggleBreakpoint<cr>" },
    { "<leader>dg", ":lua require('dap').goto_(vim.api.nvim_win_get_cursor(0)[1])<cr>" },
    { "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>" },
    { "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>" },
    { "<F5>", ":DapContinue<cr>" },
    { "<F10>", ":DapStepOver<cr>" },
    { "<F11>", ":DapStepInto<cr>" },
    { "<S-F11>", ":DapStepOut<cr>" },
  },
}
