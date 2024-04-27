return {
  "nvim-treesitter/nvim-treesitter",
  event = "BufReadPost",
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
    "nvim-tree/nvim-web-devicons",
    "windwp/nvim-ts-autotag",
  },
  main = "nvim-treesitter.configs",
  config = function()
    vim.g.skip_ts_context_commentstring_module = true
    require("nvim-treesitter.configs").setup({
      -- A list of parser names, or "all"
      -- ensure_installed = { "c", "lua", "rust" },
      -- Install parsers synchronously (only applied to `ensure_installed`)
      -- sync_install = false,

      -- Automatically install missing parsers when entering buffer
      auto_install = true,

      -- List of parsers to ignore installing (for "all")
      -- ignore_install = { "javascript" },

      highlight = {
        -- `false` will disable the whole extension
        enable = true,

        -- list of language that will be disabled
        -- disable = { "c", "rust" },

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
      },
      autopairs = {
        enable = true,
      },
      autotag = {
        enable = true,
      },
    })
  end,
}
