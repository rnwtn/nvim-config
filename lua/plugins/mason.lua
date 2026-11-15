-- Non-LSP tools to keep installed (LSP servers are listed in lspconfig.lua).
-- csharpier needs a .NET SDK, so it is not in this list; add it once dotnet is set up.
local ensure_installed = {
  "stylua",
  "prettier",
  "black",
  "gdtoolkit", -- gdformat
}

return {
  "mason-org/mason.nvim",
  cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUpdate", "MasonLog" },
  opts = {
    ui = {
      border = "single",
    },
  },
  config = function(_, opts)
    require("mason").setup(opts)
    local registry = require("mason-registry")
    registry.refresh(function()
      for _, name in ipairs(ensure_installed) do
        local ok, pkg = pcall(registry.get_package, name)
        if ok and not pkg:is_installed() then
          pkg:install()
        end
      end
    end)
  end,
  keys = {
    { "<leader>lI", "<cmd>Mason<cr>", desc = "Open Mason" },
  },
}
