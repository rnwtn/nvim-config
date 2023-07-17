return {
  "RRethy/vim-illuminate",
  event = "VeryLazy",
  config = function()
    require("illuminate").configure {
      filetypes_denylist = {
        "dirvish",
        "fugitive",
        "alpha",
        "Trouble",
        "lir",
        "Outline",
        "spectre_panel",
        "toggleterm",
        "DressingSelect",
        "TelescopePrompt",
      },
    }
  end,
  keys = {
    {
      "<a-n>",
      ':lua require"illuminate".next_reference{wrap=true}<cr>',
      desc = "Illuminate navigate next",
    },
    {
      "<a-p>",
      ':lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>',
      desc = "Illuminate navigate prev",
    },
  },
}
