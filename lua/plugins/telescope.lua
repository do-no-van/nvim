return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
		},
		keys = {
			{ "<Leader>f", "<Cmd>Telescope find_files<CR>" },
			{ "<Leader>g", "<Cmd>Telescope live_grep<CR>" },
		},
		opts = {
			defaults = {
				mappings = {
					["n"] = {
						["<CR>"] = "select_tab",
						["<Esc><CR>"] = "select_default", -- alt + enter
					},
					["i"] = {
						["<CR>"] = "select_tab",
						["<Esc><CR>"] = "select_default", -- alt + enter
					},
				},
			}
		},
		config = function(_, opts)
			local telescope = require("telescope")
			telescope.setup(opts)
			telescope.load_extension("fzf")
		end,
	},
}
