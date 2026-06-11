vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("autocmds")
require("options")
require("keymaps")
require("plugins")

vim.cmd("colorscheme gruvbox")
