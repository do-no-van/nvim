local api = vim.api
local opt = vim.opt
local win_opt = vim.wo
local global = vim.g

local utils = require("utils")

-- Misc
global.mapleader = " "

opt.mouse = "a"

opt.completeopt = "menuone,noinsert"
opt.splitbelow = true

opt.signcolumn = "yes"

opt.scrolloff = 4

opt.undofile = true

opt.ignorecase = true
opt.smartcase = true


-- Aesthetics
global.asmsyntax = "nasm"
opt.termguicolors = true

opt.showmode = false

win_opt.colorcolumn = "100,120"
opt.cursorline = true

opt.background = "dark"
-- This colorscheme is set in plugin_configs.lua
-- cmd("colorscheme onedark")

win_opt.list = true
opt.listchars = {
    tab = "<->",
    trail = "+",
    nbsp = "*",
}

win_opt.number = true
win_opt.relativenumber = true

api.nvim_create_autocmd("TextYankPost", {
    callback = function() vim.highlight.on_yank{timeout = 200} end,
})


-- Indentation
local indent = 4
opt.expandtab = true
opt.tabstop = indent
opt.shiftwidth = indent


-- Auto-saving
local autosave_files = {
    "(.*).rs",
    "Cargo.toml",
}

local function check_autosave()
    local current_file = api.nvim_buf_get_name(0)
    for _, file in ipairs(autosave_files) do
        if string.match(current_file, file.."$") then
            utils.autosave()
            break
        end
    end
end

api.nvim_create_autocmd("BufEnter", {
    callback = check_autosave,
})

