---@diagnostic disable: undefined-doc-name
return {
  "saghen/blink.cmp",
  event = "VimEnter",
  version = "v0.*",
  dependencies = {
    "rafamadriz/friendly-snippets",
    "giuxtaposition/blink-cmp-copilot",
    "zbirenbaum/copilot.lua",
  },
  opts = {
    keymap = {
      preset = "default",
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },
      ["<tab>"] = { "accept", "fallback" },
    },
    completion = {
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 0,
        window = {
          border = "single",
        },
      },
      menu = { border = "single" },
    },
    signature = { window = { border = "single" } },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer", "copilot" },
      providers = {
        copilot = {
          name = "copilot",
          module = "blink-cmp-copilot",
          score_offset = 100,
          async = true,
        },
      },
    },
  },
  opts_extend = { "sources.default" },
  config = function(_, opts)
    require("copilot").setup({
      suggestion = { enabled = false },
      panel = { enabled = false },
    })
    require("blink.cmp").setup(opts)
  end,
}
