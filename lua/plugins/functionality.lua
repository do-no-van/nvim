return {
	{
		"echasnovski/mini.comment",
		keys = {
			"gc",
		},
		config = true,
	},
	{
		"echasnovski/mini.surround",
		keys = {
			"s",
		},
		config = true,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			local autopairs = require("nvim-autopairs")
			autopairs.setup({
				check_ts = true,
			})

			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")
			cmp.event:on(
				"confirm_done",
				cmp_autopairs.on_confirm_done()
			)
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			signs = {
				add = { text = ' +' },
				change = { text = ' ~' },
				delete = { text = ' _' },
				topdelete = { text = ' ‾' },
				changedelete = { text = ' ~' },
			},
		},
	},
}
