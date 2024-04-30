return {
	{
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				component_separators = { left = "│", right = ''},
				section_separators = { left = "", right = ''},
				globalstatus = true,
			},
		},
	},
	{
		"norcalli/nvim-colorizer.lua",
		event = { "BufReadPost", "BufNewFile" },
		config = function(_, _)
			require("colorizer").setup(
				{
					"*",
					css = {
						css = true,
					},
				},
				{ -- Default options
					RGB = false,
					names = false,
				}
			)
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			show_current_context = true,
			char_highlight_list = {
				"IndentBlankLineIndent1",
			},
		},
	},
}
