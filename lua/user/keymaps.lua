local opts = { silent = true }
local keymap = vim.keymap.set

-- clear search highlights with escape
keymap("n", "<ESC>", ":noh<CR>", opts)

-- better navigation for wrapped lines)
-- keymap("n", "j", "gj", opts)
-- keymap("n", "k", "gk", opts)

-- disable mouse actions in normal mode
keymap("n", "<RightMouse>", "<NOP>", opts)
keymap("n", "<2-RightMouse>", "<NOP>", opts)
keymap("n", "<3-RightMouse>", "<NOP>", opts)
keymap("n", "<4-RightMouse>", "<NOP>", opts)
keymap("n", "<MiddleMouse>", "<NOP>", opts)
keymap("n", "<2-MiddleMouse>", "<NOP>", opts)
keymap("n", "<3-MiddleMouse>", "<NOP>", opts)
keymap("n", "<4-MiddleMouse>", "<NOP>", opts)

-- quick-switch buffer with TAB
keymap("n", "<TAB>", "<C-6>", opts)

-- nav windows with C-{h,j,k,l}
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- map escape to normal mode for terminal buffers
keymap("t", "<esc>", "<C-\\><C-n>", opts)

-- resize windows with C-arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==", opts)
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Close buffers
keymap("n", "<leader>x", ":bdelete<CR>", opts)
keymap("n", "<leader>X", ":bdelete!<CR>", opts)

-- easier indenting in visual mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Leader yank/paste to copy to system clipboard
keymap("n", "<Leader>y", '"+y', opts)
keymap("n", "<Leader>p", '"+p', opts)
keymap("n", "<Leader>P", '"+P', opts)
keymap("v", "<Leader>y", '"+y', opts)
keymap("v", "<Leader>p", '"+p', opts)
keymap("v", "<Leader>P", '"+P', opts)

-- Don't overwrite yank register when pasting over visual selection
keymap("v", "p", '"_dP', opts)

-- Setup compilation keymap on fly
keymap("n", "<Leader>C", ":map <lt>leader>c :!<lt>cr><left><left><left><left>", {})

-- Open Lazy
keymap("n", "<leader>ll", ":Lazy<cr>")

-- zen mode
keymap("n", "<leader>z", function()
  vim.cmd([[
  if tabpagenr() > 1
    tabclose
  else
    tabnew %
  endif
  ]])
end, opts)
