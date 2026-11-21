-- Type into a Claude Code session running in another tmux window.
--
-- The target is the first pane in this tmux session whose command is `claude`.
-- Override with `vim.g.claude_tmux_target = "%12"` (or any tmux target).
--
--   <leader>cr  (n/x)  type a reference like `src/foo.ts:12-30 ` into Claude
--   <leader>cp  (n/x)  ask a question about the current line/selection and submit it
--   :ClaudeTmux {text}   type text into Claude; :ClaudeTmux! also submits it
--
-- After a reference is sent, tmux switches to the Claude window so you can keep
-- typing. Set `vim.g.claude_tmux_focus = false` to stay in Neovim.

local M = {}

local function tmux(args)
  local result = vim.system(vim.list_extend({ "tmux" }, args), { text = true }):wait()
  if result.code ~= 0 then
    return nil, vim.trim(result.stderr or "")
  end
  return vim.trim(result.stdout or "")
end

local function notify(msg, level)
  vim.notify(msg, level or vim.log.levels.INFO, { title = "Claude (tmux)" })
end

--- Returns the target pane id and its working directory, or nil.
local function find_pane()
  if not vim.env.TMUX then
    notify("Neovim is not running inside tmux", vim.log.levels.WARN)
    return nil
  end

  local format = "#{pane_id}\t#{pane_current_command}\t#{pane_current_path}"
  local override = vim.g.claude_tmux_target
  local out, err
  if override then
    out, err = tmux({ "display-message", "-p", "-t", override, format })
  else
    -- -s: every pane in the session that contains this Neovim
    out, err = tmux({ "list-panes", "-s", "-t", vim.env.TMUX_PANE or "", "-F", format })
  end
  if not out then
    notify("tmux: " .. err, vim.log.levels.ERROR)
    return nil
  end

  for line in out:gmatch("[^\n]+") do
    local id, cmd, path = line:match("^(%S+)\t(.-)\t(.*)$")
    if id and (override or cmd == "claude") then
      return id, path
    end
  end
  notify("No pane running `claude` in this tmux session", vim.log.levels.WARN)
  return nil
end

--- Sends text to the Claude pane. Returns true on success.
function M.send(text, opts)
  opts = opts or {}
  local pane = find_pane()
  if not pane then
    return false
  end

  text = text:gsub("[\r\n]+", " ") -- a newline would submit early
  local _, err = tmux({ "send-keys", "-t", pane, "-l", "--", text })
  if err then
    notify("tmux: " .. err, vim.log.levels.ERROR)
    return false
  end
  if opts.submit then
    tmux({ "send-keys", "-t", pane, "Enter" })
  end
  if opts.focus then
    tmux({ "select-window", "-t", pane })
    tmux({ "select-pane", "-t", pane })
  end
  return true
end

--- `path:line` or `path:start-end`, relative to the Claude pane's directory when possible.
function M.reference(line1, line2)
  local file = vim.api.nvim_buf_get_name(0)
  if file == "" then
    notify("Buffer has no file name", vim.log.levels.WARN)
    return nil
  end
  file = vim.fs.normalize(file)

  local _, root = find_pane()
  if root and root ~= "" then
    local rel = vim.fs.relpath(vim.fs.normalize(root), file)
    if rel then
      file = rel
    end
  end

  line1, line2 = math.min(line1, line2), math.max(line1, line2)
  if line1 == line2 then
    return ("%s:%d"):format(file, line1)
  end
  return ("%s:%d-%d"):format(file, line1, line2)
end

--- Current line in normal mode, selected lines in visual mode.
local function current_lines()
  local mode = vim.fn.mode()
  if mode == "v" or mode == "V" or mode == "\22" then
    local l1, l2 = vim.fn.line("v"), vim.fn.line(".")
    vim.api.nvim_feedkeys(vim.keycode("<Esc>"), "nx", false)
    return l1, l2
  end
  local l = vim.fn.line(".")
  return l, l
end

function M.send_reference()
  local ref = M.reference(current_lines())
  if ref then
    M.send(ref .. " ", { focus = vim.g.claude_tmux_focus ~= false })
  end
end

function M.ask()
  local ref = M.reference(current_lines())
  if not ref then
    return
  end
  vim.ui.input({ prompt = "Ask Claude about " .. ref .. ": " }, function(input)
    if input and input ~= "" then
      if M.send(ref .. " " .. input, { submit = true }) then
        notify("Sent to Claude: " .. ref)
      end
    end
  end)
end

vim.api.nvim_create_user_command("ClaudeTmux", function(cmd)
  M.send(cmd.args, { submit = cmd.bang })
end, { nargs = "+", bang = true, desc = "Type text into the Claude tmux pane (! submits)" })

vim.keymap.set({ "n", "x" }, "<leader>cr", M.send_reference, { desc = "Claude: type file:line reference" })
vim.keymap.set({ "n", "x" }, "<leader>cp", M.ask, { desc = "Claude: ask about line/selection" })

return M
