return {
	"zbirenbaum/copilot.lua",
  event = "VimEnter",
	opts = {},
	keys = {
		{ "<leader>cj", ':lua require("copilot.panel").jump_next()' },
	},
}
