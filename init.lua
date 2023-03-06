vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("user.options")
require("user.keymaps").general()
require("user.plugins")

vim.cmd("colorscheme gruvbox")
