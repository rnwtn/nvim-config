vim.ui.select =  require("popui.ui-overrider")
vim.ui.input = require"popui.input-overrider"

-- Available styles: "sharp" | "rounded" | "double"
vim.g['popui_border_style'] = 'sharp'

-- Update appearance
-- hi PopuiCoordinates guifg=#6A1010 ctermfg=Red
-- hi PopuiDiagnosticsCodes guifg=#777777 ctermfg=Gray
