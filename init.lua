----------------------------------------
-- vi vi vi - the editor of the beast --
----------------------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require "user.plugin_manager"
require "user.options"
require "user.keymaps"
require "user.autocmds"

vim.cmd "colorscheme onedark"
