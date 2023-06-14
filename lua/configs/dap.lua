local M = {
  "mfussenegger/nvim-dap",
  event = "VeryLazy",
  dependencies = {
    "williamboman/mason.nvim", -- Easily install debug adapters
    "rcarriga/nvim-dap-ui", -- A more user-friendly UI for nvim-dap
    "theHamsta/nvim-dap-virtual-text", -- Debug information displayed alongside code
    "mxsdev/nvim-dap-vscode-js", -- Easily setup DAP for javascript/typescript debugging
    "David-Kunz/jester", -- Run and debug individual jest tests (Javascript/Typescript)
  },
}

function M.config()
  local dap = require "dap"

  local dap_ui_status_ok, dapui = pcall(require, "dapui")
  if not dap_ui_status_ok then
    return
  end

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
  dap.adapters.codelldb = function(cb, config)
    if config.preLaunchTask then
      vim.notify "Performing pre-launch tasks"
      config.preLaunchTask()
    end
    local adapter = {
      type = "server",
      port = "${port}",
      executable = {
        command = "codelldb",
        args = { "--port", "${port}" },
      },
    }
    cb(adapter)
  end
  dap.adapters.coreclr = function(cb, config)
    if config.preLaunchTask then
      vim.notify "Performing pre-launch tasks"
      config.preLaunchTask()
    end
    local adapter = {
      type = "executable",
      command = "netcoredbg",
      args = { "--interpreter=vscode" },
    }
    cb(adapter)
  end
  dap.adapters.godot = {
    type = "server",
    host = "127.0.0.1",
    port = 6006,
  }

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
end

return M
