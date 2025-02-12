return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"linrongbin16/lsp-progress.nvim",
	},
	config = function()
		require("lsp-progress").setup()
		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "auto",
				component_separators = { left = "|", right = "|" },
				section_separators = { left = "", right = "" },
				refresh = {
					statusline = 500,
				},
			},
			sections = {
				lualine_c = {
					require("lsp-progress").progress,
				},
				lualine_x = {
					"encoding",
					"fileformat",
					"filetype",
				},
			},
		})
	end,
}
