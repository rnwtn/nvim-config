return {
  "ThePrimeagen/harpoon",
  event = "BufEnter",
  config = function()
    require("harpoon").setup { tabline = true }
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "harpoon",
      callback = function(ev)
        local opts = { buffer = true, noremap = true, silent = true }

        -- disable certain keys in Harpoon quick menu
        vim.keymap.set("n", "x", "", opts)
        vim.keymap.set("n", "c", "", opts)
        vim.keymap.set("n", "s", "", opts)
        vim.keymap.set("n", "h", "", opts)
        vim.keymap.set("n", "l", "", opts)
        vim.keymap.set("n", "J", "", opts)
        vim.keymap.set("n", "K", "", opts)

        -- open harpoon files in vsplit with <C-V>
        vim.keymap.set("n", "<C-V>", function()
          local curline = vim.api.nvim_get_current_line()
          local working_directory = vim.fn.getcwd() .. "/"
          vim.cmd "vs"
          vim.cmd("e " .. working_directory .. curline)
        end, opts)

        -- move cursor to beginning of line
        vim.cmd "0"
      end,
    })
  end,
  keys = {
    { "<leader>a", ":lua require('harpoon.mark').add_file()<cr>", desc = "Add buffer to Harpoon list" },
    { "<leader>s", ":lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = "Open Harpoon quick menu" },
    { "<leader>u", ":lua require('harpoon.ui').nav_file(1)<cr>", desc = "Navigate to Harpoon file 1" },
    { "<leader>i", ":lua require('harpoon.ui').nav_file(2)<cr>", desc = "Navigate to Harpoon file 2" },
    { "<leader>o", ":lua require('harpoon.ui').nav_file(3)<cr>", desc = "Navigate to Harpoon file 3" },
    { "<leader>p", ":lua require('harpoon.ui').nav_file(4)<cr>", desc = "Navigate to Harpoon file 4" },
  },
}
