local M = {
  -- "ThePrimeagen/harpoon",
  dir = "~/repos/harpoon",
  event = "BufEnter",
}

M.opts = {
  tabline = true,
  tabline_offsets = {
    {
      filetype = "neo-tree",
      text = "NeoTree",
      text_align = "center",
      separator = false,
    },
    -- {
    --   filetype = "Outline",
    --   text = "Document Symbols",
    --   text_align = "center",
    --   separator = false,
    -- },
  },
}

return M
