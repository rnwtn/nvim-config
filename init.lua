vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("user.lazy")
require("user.options")
require("user.keymaps")
require("user.autocmds")

vim.cmd("colorscheme gruvbox")
