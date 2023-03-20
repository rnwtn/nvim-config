-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local opts = {}

require("lazy").setup({
  -- Colorschemes
  { 'ellisonleao/gruvbox.nvim', config = function() require('user.plugin_configs.gruvbox') end, priority = 1000, },
  { 'navarasu/onedark.nvim',    config = function() require('user.plugin_configs.onedark') end, priority = 1000, },

  -- Treesitter
  { 'nvim-treesitter/nvim-treesitter',
    config = function() require('user.plugin_configs.treesitter') end
  },

  -- LSP setup
  { 'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim' }, -- Easily install language servers
      { 'williamboman/mason-lspconfig.nvim' }, -- Integrate language servers installed through Mason
      { "jose-elias-alvarez/null-ls.nvim" }, -- Allows non-lsp sources to hook into Neovim's lsp system to provide formatting and linting.
      { "jay-babu/mason-null-ls.nvim" }, -- Allows for automatic setup of linters and formatters installed via Mason
      { 'folke/neodev.nvim' }, -- Better support for neovim lua
      { 'simrat39/rust-tools.nvim' }, -- Better rust language support
      { 'j-hui/fidget.nvim' }, -- Displays LSP setup progress in lower-right-hand corner
      -- { 'weilbith/nvim-code-action-menu' }, -- Code actions in a popup
      { 'b0o/schemastore.nvim' }, -- Schemas for jsonls
    },
    config = function() require("user.plugin_configs.lsp") end,
  },

  -- DAP setup
  { 'mfussenegger/nvim-dap',
    dependencies = {
      { 'williamboman/mason.nvim' }, -- Easily install debug adapters
      { 'rcarriga/nvim-dap-ui' }, -- A more user-friendly UI for nvim-dap
      { 'theHamsta/nvim-dap-virtual-text' }, -- Debug information displayed alongside code
    },
    config = function() require("user.plugin_configs.dap") end,
  },

  -- Autocompletion and snippets
  { 'hrsh7th/nvim-cmp',
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' }, -- Completions from Neovim's built-in LSP client
      { 'hrsh7th/cmp-buffer' }, -- Completions from text in buffer
      { 'hrsh7th/cmp-path' }, -- Completions from file paths
      { 'hrsh7th/cmp-cmdline' }, -- Completions for the command line
      { 'hrsh7th/cmp-nvim-lua' }, -- Completions specific for Neovim's lua
      { 'saadparwaiz1/cmp_luasnip' }, -- Completions from luasnip
      { 'L3MON4D3/LuaSnip' }, -- This provides snippets to CMP
      { 'rafamadriz/friendly-snippets' }, -- A huge collection of snippets for a variety of languages
    },
    config = function() require("user.plugin_configs.cmp") end,
  },

  -- Document Symbols
  { 'simrat39/symbols-outline.nvim',
    config = function() require("user.plugin_configs.symbols_outline") end,
  },

  -- Fuzzy finder
  { 'nvim-telescope/telescope.nvim',
    tag = '0.1.1',
    dependencies = 'nvim-lua/plenary.nvim',
    config = function() require("user.plugin_configs.telescope") end,
  },

  -- bufferline
  { 'akinsho/bufferline.nvim',
    tag = "v3.2.0",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function() require("user.plugin_configs.bufferline") end,
  },

  -- Statusline
  { 'nvim-lualine/lualine.nvim',
    config = function() require("user.plugin_configs.lualine") end,
  },

  -- Context bar
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {},
  },

  -- File explorer
  { 'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    tag          = 'nightly', -- optional, updated every week. (see issue #1193)
    config       = function() require("user.plugin_configs.nvimtree") end,
  },

  -- Better exiting buffers
  { 'moll/vim-bbye',
    config = function()
      -- Register keymaps
      require('user.keymaps').bbye()
    end
  },

  -- Easily comment stuff
  { 'numToStr/Comment.nvim',
    config = function() require('Comment').setup() end,
  },

  -- Git integration
  { 'lewis6991/gitsigns.nvim',
    config = function() require('user.plugin_configs.gitsigns') end,
  },

  -- Better popup for
  { 'hood/popui.nvim',
    config = function() require('user.plugin_configs.popui') end,
  },

  -- Zen mode
  { 'folke/zen-mode.nvim',
    config = function() require('user.plugin_configs.zenmode') end,
  },

  -- Color RGB hexcodes
  { 'NvChad/nvim-colorizer.lua',
    config = function() require('user.plugin_configs.nvim_colorizer') end
  },

  { 'akinsho/toggleterm.nvim',
    config = function() require('user.plugin_configs.toggleterm') end
  },

  -- auto-close parentheses, brackets, and others
  { 'windwp/nvim-autopairs',
    config = function() require('nvim-autopairs').setup {} end
  },

  -- auto-close parentheses, brackets, and others
  { 'petertriho/nvim-scrollbar',
    dependencies = {
      -- 'kevinhwang91/nvim-hlslens'
    },
    config = function() require("scrollbar").setup() end
  },
}, opts)
