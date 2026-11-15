-- Requires a .NET SDK and roslyn-language-server (`:MasonInstall roslyn`).
-- Razor/CSHTML support is built in now (rzls.nvim is archived).
return {
  "seblyng/roslyn.nvim",
  ft = { "cs", "razor" },
  opts = {},
}
