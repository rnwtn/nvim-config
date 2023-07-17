local opts = { silent = true }
local keymap = vim.keymap.set
keymap("n", "<leader>s", ":w<CR>", opts) -- Save with <leader>S
keymap("n", "<ESC>", ":noh<CR>", opts) -- clear search highlights with escape
keymap("n", "j", "gj", opts) -- better navigation for wrapped lines
keymap("n", "k", "gk", opts)
keymap("n", "<C-h>", "<C-w>h", opts) -- nav windows with C-{h,j,k,l}
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<C-Up>", ":resize -2<CR>", opts) -- resize windows with C-arrows
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==", opts) -- Move text up and down
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==", opts)
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)
keymap("n", "<leader>x", ":bdelete<CR>", opts) -- Close buffers
keymap("n", "<leader>X", ":bdelete!<CR>", opts)
keymap("v", "<", "<gv", opts) -- easier indenting in visual mode
keymap("v", ">", ">gv", opts)
keymap("v", "p", '"_dP', opts) -- Don't overwrite yank register when pasting over visual selection
keymap("n", "<Leader>C", ":map <lt>leader>c :!<lt>cr><left><left><left><left>", {}) -- Setup compilation keymap on fly
keymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", opts) -- open lazygit
keymap("n", "<leader>du", ":lua require('dapui').toggle({ reset = true })<cr>", opts) -- DAP
keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts)
keymap("n", "<leader>db", ":DapToggleBreakpoint<cr>", opts)
keymap("n", "<leader>dg", ":lua require('dap').goto_(vim.api.nvim_win_get_cursor(0)[1])<cr>", opts)
keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts)
keymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", opts)
keymap("n", "<F5>", ":DapContinue<cr>", opts)
keymap("n", "<F10>", ":DapStepOver<cr>", opts)
keymap("n", "<F11>", ":DapStepInto<cr>", opts)
keymap("n", "<S-F11>", ":DapStepOut<cr>", opts)
keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", opts) -- Lsp
