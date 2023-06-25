-- set borders for floating windows
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	opts = opts or {}
	opts.border = opts.border or {
		{"┌", "FloatBorder"},
		{"─", "FloatBorder"},
		{"┐", "FloatBorder"},
		{"│", "FloatBorder"},
		{"┘", "FloatBorder"},
		{"─", "FloatBorder"},
		{"└", "FloatBorder"},
		{"│", "FloatBorder"},
	}

	return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- change the diagnostic icons in the gutter
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- built-in diagnostic settings
vim.diagnostic.config({
	severity_sort = true,
	update_in_insert = true,
})

return {
	{
		"neovim/nvim-lspconfig",
		ft = "lua",
		config = function(_, _)
			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({
				settings = {
					Lua = {
						runtime = {
							version = "LuaJit",
						},
						diagnostics = {
							globals = {
								"vim",
							},
						},
					},
				},
			})
		end,
	},
	{
		"j-hui/fidget.nvim",
		opts = {
			text = {
				spinner = "dots",
			}
		},
	},
	{
		"simrat39/rust-tools.nvim",
		ft = "rust",
		opts = {
			tools = {
				runnables = {
					use_telescope = true,
				},
				hover_actions = {
					auto_focus = true,
				},
			},
			server = {
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
				settings = {
					["rust-analyzer"] = {
						cargo = {
							runBuildScripts = true,
						},
					procMacro = {
						enable = true,
					},
					checkOnSave = {
						command = "clippy",
					},
				},
			},
			on_attach = function(_, bufnr)
				local utils = require("utils")
				local rust_tools = require("rust-tools")

				utils.map({
					normal = {
						["gh"] = { function() utils.diagnostic_or(rust_tools.hover_actions.hover_actions) end, { buffer = bufnr } },
					},
				})
			end,
			},
		},
	},
	{
		"saecki/crates.nvim",
		event = "BufEnter Cargo.toml",
		config = function(_, _)
			require("crates").setup()
			require("cmp").setup.buffer({ sources = {{ name = "crates" }}})
		end,
	},
}
