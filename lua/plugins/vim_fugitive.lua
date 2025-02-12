return {
	"tpope/vim-fugitive",
	event = "VimEnter",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "fugitive",
			callback = function()
				local opts = { buffer = true, noremap = true, silent = true }
				vim.keymap.set("n", "<leader>gs", ":q<cr>", opts)
				vim.keymap.set("n", "q", ":q<cr>", opts)
			end,
		})
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "gitcommit",
			callback = function()
				local opts = { buffer = true, noremap = true, silent = true }
				vim.keymap.set("n", "q", ":q!<cr>", opts)
				vim.keymap.set("n", "<leader>gc", ":q!<cr>", opts)
				-- vim.cmd "startinsert"
			end,
		})
	end,
	keys = {
		-- {
		--   "<leader>gs",
		--   function()
		--     vim.cmd "tabnew"
		--     vim.cmd "Git"
		--     vim.cmd ":only"
		--   end,
		--   desc = "Git open Vim-Fugitive",
		-- },
		{ "<leader>gs", ":Git<cr>", desc = "Git open Vim-Fugitive" },
		{ "<leader>gp", ":Git pull<cr>", desc = "Git pull" },
		{ "<leader>gP", ":Git push<cr>", desc = "Git push" },
		{ "<leader>gc", ":Git commit --no-verify<cr>", desc = "Git push" },
	},
}
