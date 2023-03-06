local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'rounded' })
    end,
  },
})

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- Allow packer to manage itself

  -- Colors
  use 'navarasu/onedark.nvim'
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- LSP support
  use {
    'neovim/nvim-lspconfig',
    requires = {
      { 'williamboman/mason.nvim' }, -- Easily install language servers
      { 'williamboman/mason-lspconfig.nvim' }, -- Integrate language servers installed through Mason
      { "jose-elias-alvarez/null-ls.nvim" }, -- Allows non-lsp sources to hook into Neovim's lsp system to provide formatting and linting.
      { "jay-babu/mason-null-ls.nvim" }, -- Allows for automatic setup of linters and formatters installed via Mason
      { 'simrat39/rust-tools.nvim' }, -- Better rust language support
      { 'j-hui/fidget.nvim' }, -- Displays LSP setup progress in lower-right-hand corner
    }
  }

  -- Autocompletion and Snippets
  use {
    'hrsh7th/nvim-cmp', -- Required
    requires = {
      { 'hrsh7th/cmp-nvim-lsp' }, -- Completions from Neovim's built-in LSP client
      { 'hrsh7th/cmp-buffer' }, -- Completions from text in buffer
      { 'hrsh7th/cmp-path' }, -- Completions from file paths
      { 'hrsh7th/cmp-cmdline' }, -- Completions for the command line
      { 'hrsh7th/cmp-nvim-lua' }, -- Completions specific for Neovim's lua
      { 'saadparwaiz1/cmp_luasnip' }, -- Completions from luasnip
      { 'L3MON4D3/LuaSnip' }, -- This provides snippets to CMP
      { 'rafamadriz/friendly-snippets' }, -- A huge collection of snippets for a variety of languages
    }
  }

  -- Fuzzy finder
  use { 'nvim-telescope/telescope.nvim',
    tag = '0.1.1',
    requires = 'nvim-lua/plenary.nvim'
  }

  -- bufferline
  use { 'akinsho/bufferline.nvim',
    tag = "v3.*",
    requires = 'nvim-tree/nvim-web-devicons'
  }

  -- Statusline
  use 'nvim-lualine/lualine.nvim'

  -- File explorer
  use { 'nvim-neo-tree/neo-tree.nvim',
    branch = 'v2.x',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
    }
  }

  -- Better exiting buffers
  use { 'moll/vim-bbye',
    config = function()
      -- Register keymaps
      require('core.keymaps').bbye()
    end
  }

  -- Easily comment stuff
  use { 'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }

  -- Git integration
  use 'lewis6991/gitsigns.nvim'

  if packer_bootstrap then
    require('packer').sync()
  end
end)
