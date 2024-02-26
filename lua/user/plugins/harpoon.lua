return {
  "ThePrimeagen/harpoon",
  event = "BufEnter",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    settings = {
      save_on_toggle = true,
    },
  },
  keys = {
    { "<leader>u", ":lua require('harpoon'):list():select(1)<cr>", desc = "Navigate to Harpoon file 1" },
    { "<leader>i", ":lua require('harpoon'):list():select(2)<cr>", desc = "Navigate to Harpoon file 2" },
    { "<leader>o", ":lua require('harpoon'):list():select(3)<cr>", desc = "Navigate to Harpoon file 3" },
    { "<leader>p", ":lua require('harpoon'):list():select(4)<cr>", desc = "Navigate to Harpoon file 4" },
    { "<leader>9", ":lua require('harpoon'):list():prev()<cr>",    desc = "Navigate to Harpoon previous file" },
    { "<leader>0", ":lua require('harpoon'):list():next()<cr>",    desc = "Navigate to Harpoon next file" },
    { "<leader>a", ":lua require('harpoon'):list():append()<cr>",  desc = "Add buffer to Harpoon list" },
    {
      "<leader>s",
      ":lua require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())<cr>",
      desc = "Open Harpoon quick menu",
      silent = true,
    },
  },
}
