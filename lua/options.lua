local api = vim.api
local opt = vim.opt
local win_opt = vim.wo
local global = vim.g

-- misc
global.mapleader = " "

opt.mouse = "a"

opt.completeopt = "menuone,noinsert"

opt.splitbelow = true;

opt.signcolumn = "yes"

opt.scrolloff = 4

opt.undofile = true

opt.ignorecase = true
opt.smartcase = true

-- aesthetics
global.asmsyntax = "nasm"

opt.termguicolors = true

opt.showmode = false

win_opt.colorcolumn = "100,120"
opt.cursorline = true

opt.background = "dark"

win_opt.list = true
opt.listchars = {
	tab = "  ",
	trail = "+",
	nbsp = "*",
}

win_opt.number = true
win_opt.relativenumber = true

api.nvim_create_autocmd("TextYankPost", {
	callback = function() vim.highlight.on_yank({ timeout = 200 }) end,
})

opt.laststatus = 3

-- indentation
local indent = 4
opt.tabstop = indent
opt.shiftwidth = indent
