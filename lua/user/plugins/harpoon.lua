return {
  "ThePrimeagen/harpoon",
  event = "BufEnter",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    vim.api.nvim_create_autocmd({ "FileType" }, {
      pattern = { "harpoon" },
      callback = function()
        local opts = { buffer = true, noremap = true, silent = true }
        vim.keymap.set(
          "n",
          "<2-LeftMouse>",
          ":lua require('harpoon'):list():select(vim.api.nvim_win_get_cursor(0)[1])<cr>",
          opts
        )
        vim.keymap.set("n", "<RightMouse>", "<NOP>", opts)
      end,
    })
    local harpoon = require("harpoon")
    local extensions = require("harpoon.extensions")
    harpoon:setup()
    harpoon:extend(extensions.builtins.navigate_with_number())
  end,
  keys = {
    { "<leader>1", ":lua require('harpoon'):list():select(1)<cr>", desc = "Navigate to Harpoon file 1" },
    { "<leader>2", ":lua require('harpoon'):list():select(2)<cr>", desc = "Navigate to Harpoon file 2" },
    { "<leader>3", ":lua require('harpoon'):list():select(3)<cr>", desc = "Navigate to Harpoon file 3" },
    { "<leader>4", ":lua require('harpoon'):list():select(4)<cr>", desc = "Navigate to Harpoon file 4" },
    { "<leader>5", ":lua require('harpoon'):list():select(5)<cr>", desc = "Navigate to Harpoon file 5" },
    { "<leader>6", ":lua require('harpoon'):list():select(6)<cr>", desc = "Navigate to Harpoon file 6" },
    { "<leader>7", ":lua require('harpoon'):list():select(7)<cr>", desc = "Navigate to Harpoon file 7" },
    { "<leader>8", ":lua require('harpoon'):list():select(8)<cr>", desc = "Navigate to Harpoon file 8" },
    { "<leader>9", ":lua require('harpoon'):list():select(9)<cr>", desc = "Navigate to Harpoon file 9" },
    { "<leader>0", ":lua require('harpoon'):list():select(10)<cr>", desc = "Navigate to Harpoon file 10" },
    { "<leader>a", ":lua require('harpoon'):list():add()<cr>", desc = "Add buffer to Harpoon list" },
    {
      "s",
      ":lua require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())<cr>",
      desc = "Open Harpoon quick menu",
      silent = true,
    },
    {
      "<MiddleMouse>",
      ":lua require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())<cr>",
      desc = "Open Harpoon quick menu",
      silent = true,
    },
    {
      "<2-MiddleMouse>",
      ":lua require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())<cr>",
      desc = "Open Harpoon quick menu",
      silent = true,
    },
    {
      "<3-MiddleMouse>",
      ":lua require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())<cr>",
      desc = "Open Harpoon quick menu",
      silent = true,
    },
    {
      "<4-MiddleMouse>",
      ":lua require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())<cr>",
      desc = "Open Harpoon quick menu",
      silent = true,
    },
  },
}
