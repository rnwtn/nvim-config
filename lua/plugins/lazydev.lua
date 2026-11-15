-- Configures lua_ls for editing this config (replaces the manual
-- workspace.library / globals = { "vim" } settings).
return {
  "folke/lazydev.nvim",
  ft = "lua",
  opts = {
    library = {
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      { path = "snacks.nvim", words = { "Snacks" } },
    },
  },
}
