local dap = require("dap")

-- setup keymaps for dap
require("user.keymaps").dap()

-- Set custom breakpoint signs
vim.fn.sign_define('DapStopped', { text = '=>', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpoint', { text = 'B', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointCondition', { text = 'C', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointRejected', { text = 'R', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapLogPoint', { text = 'L', texthl = '', linehl = '', numhl = '' })

-- Setup adapters
dap.adapters.codelldb = function(cb, config)
  if config.preLaunchTask then
    vim.notify("Performing pre-launch tasks")
    config.preLaunchTask()
  end
  local adapter = {
    type = 'server',
    port = "${port}",
    executable = {
      command = "codelldb",
      args = { "--port", "${port}" },
    }
  }
  cb(adapter)
end

require('dap-vscode-js').setup({
  debugger_path = vim.fn.stdpath('data') .. '/mason/packages/js-debug-adapter',
  debugger_cmd = { 'js-debug-adapter' },
  adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
})

-- Setup default launch configurations
local codelldb_config = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
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
      '${workspaceFolder}/dist/**/*.js',
      '${workspaceFolder}/dist/*.js',
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
      '${workspaceFolder}/dist/**/*.js',
      '${workspaceFolder}/dist/*.js',
    },
  },
}

dap.configurations.cpp = codelldb_config
dap.configurations.c = codelldb_config
dap.configurations.rust = codelldb_config
dap.configurations.typescript = node_config
dap.configurations.javascript = node_config

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

-- Set virtual text when debugging
require("nvim-dap-virtual-text").setup({})

-- Setup the UI
local dapui = require("dapui")

-- register listeners to open and close dapui automatically
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open({ reset = true })
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

dapui.setup({
  icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  -- Expand lines larger than the window
  -- Requires >= 0.7
  expand_lines = true,
  -- Layouts define sections of the screen to place windows.
  -- The position can be "left", "right", "top" or "bottom".
  -- The size specifies the height/width depending on position. It can be an Int
  -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
  -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
  -- Elements are the elements shown in the layout (in order).
  -- Layouts are opened in order so that earlier layouts take priority in window sizing.
  -- layouts = {
  --   {
  --     elements = {
  --       -- Elements can be strings or table with id and size keys.
  --       { id = "scopes", size = 0.25 },
  --       "breakpoints",
  --       "stacks",
  --       "watches",
  --     },
  --     size = 40, -- 40 columns
  --     position = "left",
  --   },
  --   {
  --     elements = {
  --       "repl",
  --       "console",
  --     },
  --     size = 0.25, -- 25% of total lines
  --     position = "bottom",
  --   },
  -- },
  -- floating = {
  --   max_height = nil, -- These can be integers or a float between 0 and 1.
  --   max_width = nil, -- Floats will be treated as percentage of your screen.
  --   border = "single", -- Border style. Can be "single", "double" or "rounded"
  --   mappings = {
  --     close = { "q", "<Esc>" },
  --   },
  -- },
  -- windows = { indent = 1 },
  -- render = {
  --   max_type_length = nil, -- Can be integer or nil.
  --   max_value_lines = 100, -- Can be integer or nil.
  -- }
})
