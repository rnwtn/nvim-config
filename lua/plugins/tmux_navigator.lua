return {
  "christoomey/vim-tmux-navigator",
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
  },
  init = function()
    -- <C-\> is used for the floating terminal (see snacks.lua)
    vim.g.tmux_navigator_no_mappings = 1
    vim.g.tmux_navigator_disable_when_zoomed = 1
  end,
  keys = {
    { "<C-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "Navigate left (window/tmux pane)" },
    { "<C-j>", "<cmd>TmuxNavigateDown<cr>", desc = "Navigate down (window/tmux pane)" },
    { "<C-k>", "<cmd>TmuxNavigateUp<cr>", desc = "Navigate up (window/tmux pane)" },
    { "<C-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Navigate right (window/tmux pane)" },
  },
}
