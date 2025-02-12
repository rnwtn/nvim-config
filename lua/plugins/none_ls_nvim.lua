return {
	"nvimtools/none-ls.nvim",
	event = "BufReadPre",
	dependencies = {
		{
			"nvimtools/none-ls-extras.nvim",
			"nvim-lua/plenary.nvim",
			lazy = true,
		},
	},
	config = function()
		local null_ls = require("null-ls")
		-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
		local formatting = null_ls.builtins.formatting
		-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
		-- local diagnostics = null_ls.builtins.diagnostics
		-- local code_actions = null_ls.builtins.code_actions

		-- https://github.com/prettier-solidity/prettier-plugin-solidity
		null_ls.setup({
			debug = false,
			sources = {
				require("none-ls.code_actions.eslint_d"),
				formatting.prettier.with({ extra_filetypes = { "toml" } }),
				formatting.stylua,
			},
		})
	end,
}
