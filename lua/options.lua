local api = vim.api
local cmd = vim.cmd
local opt = vim.opt
local win_opt = vim.wo
local global = vim.g

-- misc
global.mapleader = " "

opt.splitbelow = true;

opt.signcolumn = "yes"

opt.scrolloff = 8

opt.undofile = true

opt.hlsearch = false

opt.ignorecase = true
opt.smartcase = true

-- aesthetics
opt.termguicolors = true

opt.showmode = false

win_opt.colorcolumn = "80,100,120"
opt.cursorline = true

opt.wrap = false

cmd.colorscheme("kule")

win_opt.list = true
opt.listchars = {
	tab = "  ",
	trail = "+",
	nbsp = "*",
}

win_opt.number = true
win_opt.relativenumber = true

api.nvim_create_autocmd("TextYankPost", {
	callback = function() vim.highlight.on_yank({ timeout = 100 }) end,
})

opt.laststatus = 3

-- indentation
local indent = 4
opt.tabstop = indent
opt.shiftwidth = indent
