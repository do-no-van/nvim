local utils = require("utils")

local diagnostic_icons = { Error = " ", Warn = " ", Hint = " ", Info = " " }

local function on_attach(callback)
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			local buffer = args.buf

			callback(client, buffer)
		end,
	})
end

return {}
-- return {
-- 	{
-- 		"neovim/nvim-lspconfig",
-- 		dependencies = {
-- 			{
-- 				"j-hui/fidget.nvim",
-- 				tag = "legacy",
-- 				opts = {
-- 					text = {
-- 						spinner = "dots",
-- 					}
-- 				},
-- 			},
-- 		},
-- 		event = { "BufReadPre", "BufNewFile" },
-- 		opts = {
-- 			servers = {
-- 				lua_ls = {
-- 					settings = {
-- 						Lua = {
-- 							diagnostics = {
-- 								globals = {
-- 									"vim",
-- 								},
-- 							},
-- 							telemetry = {
-- 								enable = false,
-- 							},
-- 						},
-- 					}
-- 				},
-- 				rust_analyzer = {
-- 					settings = {
-- 						["rust-analyzer"] = {
-- 							check = {
-- 								-- command = "clippy",
-- 							},
-- 							typing = {
-- 								autoClosingAngleBrackets = {
-- 									enable = true,
-- 								},
-- 							},
-- 						},
-- 					},
-- 				},
-- 			},
-- 			setup = {
-- 				rust_analyzer = function(_, opts)
-- 					local rust_tools_opts = {
-- 						tools = {
-- 							runnables = {
-- 								use_telescope = true,
-- 							},
-- 							hover_actions = {
-- 								auto_focus = true,
-- 							},
-- 						},
-- 					}
-- 					vim.tbl_deep_extend("error", rust_tools_opts, opts)
--
-- 					require("rust-tools").setup(rust_tools_opts)
--
-- 					on_attach(function(_, buffer)
-- 						local rust_tools = require("rust-tools")
--
-- 						utils.map({
-- 							normal = {
-- 								["gh"] = { function() utils.diagnostic_or(rust_tools.hover_actions.hover_actions) end, { buffer = buffer } },
-- 							},
-- 						})
-- 					end)
-- 				end,
-- 			}
-- 		},
-- 		config = function(_, opts)
-- 			-- change the diagnostic icons in the gutter
-- 			for type, icon in pairs(diagnostic_icons) do
-- 				local hl = "DiagnosticSign" .. type
-- 				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
-- 			end
--
-- 			-- set borders for floating windows
-- 			local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
-- 			function vim.lsp.util.open_floating_preview(contents, syntax, options, ...)
-- 				options = options or {}
-- 				options.border = options.border or "single"
--
-- 				return orig_util_open_floating_preview(contents, syntax, options, ...)
-- 			end
--
-- 			on_attach(function(client, buffer)
-- 				utils.map({
-- 					normal = {
-- 						["<Leader>r"] = vim.lsp.buf.rename,
-- 						["<Leader>a"] = vim.lsp.buf.code_action,
-- 						["<Leader>F"] = function() vim.lsp.buf.format({ async = true }) end,
-- 						["gd"] = vim.lsp.buf.definition,
-- 						["gt"] = vim.lsp.buf.type_definition,
-- 						["gh"] = function() utils.diagnostic_or(vim.lsp.buf.hover) end,
-- 						["gH"] = vim.lsp.buf.hover,
-- 						["gE"] = vim.diagnostic.goto_prev,
-- 						["ge"] = vim.diagnostic.goto_next,
-- 					},
-- 				}, true)
--
-- 				if client.server_capabilities.inlayHintProvider then
-- 					vim.lsp.inlay_hint(buffer, true)
-- 				end
-- 			end)
--
-- 			vim.diagnostic.config({
-- 				severity_sort = true,
-- 				update_in_insert = true,
-- 				-- prefix = function(diagnostic)
-- 				-- 	for type, icon in pairs(diagnostic_icons) do
-- 				-- 		print(diagnostic)
-- 				-- 		if diagnostic.severity == vim.diagnostic.severity[type:upper()] then
-- 				-- 			return icon
-- 				-- 		end
-- 				-- 	end
-- 				-- end,
-- 			})
--
-- 			local default_opts = {
-- 				capabilities = vim.tbl_deep_extend(
-- 					"force",
-- 					vim.lsp.protocol.make_client_capabilities(),
-- 					require("cmp_nvim_lsp").default_capabilities()
-- 				),
-- 			}
--
-- 			for server, server_opts in pairs(opts.servers) do
-- 				server_opts = vim.tbl_deep_extend(
-- 					"force",
-- 					default_opts,
-- 					server_opts
-- 				)
--
--
-- 				-- avoid being setup by lspconfig if the setup function returns true
-- 				if opts.setup[server] and opts.setup[server](server, server_opts) then
-- 					return
-- 				end
--
-- 				require("lspconfig")[server].setup(server_opts)
-- 			end
-- 		end,
-- 	},
-- 	{
-- 		"simrat39/rust-tools.nvim",
-- 		lazy = true,
-- 	},
-- 	{
-- 		"saecki/crates.nvim",
-- 		event = "BufEnter Cargo.toml",
-- 		config = function(_, _)
-- 			require("crates").setup()
-- 			require("cmp").setup.buffer({ sources = {{ name = "crates" }}})
-- 		end,
-- 	},
-- }
