-- Claude Code IDE integration. Claude runs in its own tmux window; start it with
-- `claude --ide` (or run /ide) from the project directory to connect.
-- Shares the current file/selection and diagnostics, and shows Claude's edits as diffs.
-- Typing into the Claude pane is handled by lua/config/claude_tmux.lua.
return {
  "coder/claudecode.nvim",
  event = "VeryLazy", -- start the server at launch so `claude --ide` finds it
  opts = {
    terminal = { provider = "none" },
  },
  keys = {
    { "<leader>cb", "<cmd>ClaudeCodeAdd %<cr>", desc = "Claude: add buffer to context" },
    { "<leader>cs", "<cmd>ClaudeCodeSend<cr>", mode = "x", desc = "Claude: add selection to context" },
    { "<leader>ca", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Claude: accept diff" },
    { "<leader>cd", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Claude: deny diff" },
  },
}
