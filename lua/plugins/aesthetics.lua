local cursor_pos_bg = "#252525"

return {
	{
		"navarasu/onedark.nvim",
		priority = 64,
		opts = {
			style = "warm",
			highlights = {
				CursorColumn = { bg = cursor_pos_bg },
				CursorLine = { bg = cursor_pos_bg },
				CursorLineNr = { fg = "#eeeeee" },
				NormalFloat = { bg = "background" },
				FloatBorder = { fg = "#cccccc", bg = "background" },
				IndentLine = { fg = "#444444" },
				GitSignsAdd = { fg = "#33ff55" },
				GitSignsChange = { fg = "#44bbff" },
				GitSignsDelete = { fg = "#ff5566" },
				TSComment = { fg = "#888888" },
				TreesitterContextSeparator = { fg = "#444444" }
			},
		},
		config = function(_, opts)
			local onedark = require("onedark")
			onedark.setup(opts)
			onedark.load()
		end,
	},
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
		opts = {
			show_current_context = true,
			char_highlight_list = {
				"IndentLine",
			},
		},
	},
	{
		"kyazdani42/nvim-web-devicons",
		lazy = true,
		config = true,
	},
}
