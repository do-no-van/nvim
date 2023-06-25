return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
		config = function(_, _)
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "rust", "toml", "lua", "c", "cpp" },
				highlight = {
					enable = true,
				},
				indent = {
					enable = true,
				},
				autotags = {
					enable = true,
					filetypes = { "xml" },
				},
			})

			-- there is no xml parser, use the html parser instead	
			vim.treesitter.language.register("html", "xml")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		opts = {
			separator = "─",
		},
		config = true,
	},
}
