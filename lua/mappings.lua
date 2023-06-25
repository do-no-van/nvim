local lsp = vim.lsp
local utils = require("utils")

utils.map({
	normal_visual = {
		["H"] = "^",
		["J"] = "<C-f>",
		["K"] = "<C-b>",
		["L"] = "$",
		["<C-c>"] = '"+y',
		["<C-h>"] = "<Cmd>wincmd h<CR>",
		["<C-j>"] = "<Cmd>wincmd j<CR>",
		["<C-k>"] = "<Cmd>wincmd k<CR>",
		["<C-l>"] = "<Cmd>wincmd l<CR>",
	},
	insert = {
		["<Esc>"] = "<Esc>l",
		["<S-Tab>"] = "<C-d>",
		["<C-c>"] = '"+y',
		["<C-h>"] = "<Cmd>wincmd h<CR>",
		["<C-j>"] = "<Cmd>wincmd j<CR>",
		["<C-k>"] = "<Cmd>wincmd k<CR>",
		["<C-l>"] = "<Cmd>wincmd l<CR>",
		["<C-t>"] = utils.toggle_term,
	},
	normal = {
		-- editing bindings
		["<Leader>j"] = "J",
		["U"] = "<C-r>",
		["<Leader>r"] = lsp.buf.rename,
		["<Leader>a"] = lsp.buf.code_action,
		["<Leader>F"] = function() lsp.buf.format({ async = true }) end,

		-- editor bindings
		["<Leader>L"] = "<Cmd>Lazy<CR>",
		["gd"] = lsp.buf.definition,
		["gt"] = lsp.buf.type_definition,
		["gh"] = function() utils.diagnostic_or(lsp.buf.hover) end,
		["gH"] = lsp.buf.hover,
		["gE"] = vim.diagnostic.goto_prev,
		["ge"] = vim.diagnostic.goto_next,
		["<Leader>,"] = "<Cmd>tabprevious<CR>",
		["<Leader>."] = "<Cmd>tabnext<CR>",
		["<Leader><"] = "<Cmd>tabmove -1<CR>",
		["<Leader>>"] = "<Cmd>tabmove +1<CR>",
		["<Leader>c"] = "<Cmd>quit!<CR>",
		["<Leader>w"] = "<Cmd>wall!<CR>",
		["<Leader>e"] = "<Cmd>x!<CR>",
		["<Leader>v"] = "<Cmd>split<CR><Cmd>wincmd j<CR>",
		["<Leader>s"] = "<Cmd>vsplit<CR><Cmd>wincmd l<CR>",
		["<C-t>"] = utils.toggle_term,
		["<C-\\>"] = "<Cmd>lua vim.o.cursorcolumn = not vim.o.cursorcolumn<CR>",
		["<Leader>C"] = "<Cmd>TSContextToggle<CR>"
	},
	visual = {
		["<"] = "<gv",
		[">"] = ">gv",
	},
	terminal = {
		["<Esc>"] = "<C-\\><C-n>",
		["<C-t>"] = utils.toggle_term,
		["<C-h>"] = "<Cmd>wincmd h<CR>",
		["<C-j>"] = "<Cmd>wincmd j<CR>",
		["<C-k>"] = "<Cmd>wincmd k<CR>",
		["<C-l>"] = "<Cmd>wincmd l<CR>",
	},
})
