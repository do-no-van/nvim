local lsp = vim.lsp

-- Escape mappings are done in plugin_configs.lua
require("utils").map{
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
        ["<S-Tab>"] = "<C-d>",
        ["<C-c>"] = '"+y',
        ["<C-h>"] = "<Cmd>wincmd h<CR>",
        ["<C-j>"] = "<Cmd>wincmd j<CR>",
        ["<C-k>"] = "<Cmd>wincmd k<CR>",
        ["<C-l>"] = "<Cmd>wincmd l<CR>",
        ["<C-t>"] = require("utils").toggle_term,
    },
    normal = {
        -- Editing bindings
        ["<Leader>j"] = "J",
        ["U"] = "<C-r>",
        ["<Leader>r"] = lsp.buf.rename,
        ["<Leader>a"] = lsp.buf.code_action,
        ["<Leader>F"] = lsp.buf.formatting,

        -- Editor bindings
        ["<Leader>l"] = require("cargo_clippy").clippy,
        ["<Leader>L"] = require("cargo_clippy").clear,
        ["<C-s>"] = require("utils").autosave,
        ["gd"] = lsp.buf.definition,
        ["gt"] = lsp.buf.type_definition,
        ["gh"] = require("utils").diagnostic_or_hover,
        ["gE"] = vim.diagnostic.goto_prev,
        ["ge"] = vim.diagnostic.goto_next,
        ["<Leader>,"] = "<Cmd>tabprevious<CR>",
        ["<Leader>."] = "<Cmd>tabnext<CR>",
        ["<Leader><"] = "<Cmd>tabmove -1<CR>",
        ["<Leader>>"] = "<Cmd>tabmove +1<CR>",
        ["<Leader>c"] = "<Cmd>quit!<CR>",
        ["<Leader>w"] = "<Cmd>wall!<CR>",
        ["<Leader>e"] = "<Cmd>x!<CR>",
        ["<Leader>f"] = "<Cmd>Telescope find_files<CR>",
        ["<Leader>g"] = "<Cmd>Telescope live_grep<CR>",
        ["<C-t>"] = require("utils").toggle_term,
        ["<C-\\>"] = "<Cmd>lua vim.o.cursorcolumn = not vim.o.cursorcolumn<CR>",
        ["<Leader>s"] = "<Cmd>split<CR><Cmd>wincmd j<CR>",
        ["<Leader>v"] = "<Cmd>vsplit<CR><Cmd>wincmd l<CR>",
    },
    visual = {
        ["<"] = "<gv",
        [">"] = ">gv",
    },
    terminal = {
        ["<C-t>"] = require("utils").toggle_term,
        ["<C-h>"] = "<Cmd>wincmd h<CR>",
        ["<C-j>"] = "<Cmd>wincmd j<CR>",
        ["<C-k>"] = "<Cmd>wincmd k<CR>",
        ["<C-l>"] = "<Cmd>wincmd l<CR>",
    },
}

