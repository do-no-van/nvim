local lsp = vim.lsp
local utils = require("utils")

-- Escape mappings are done in lua/plugin_configs.lua
utils.map{
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
        ["<C-t>"] = utils.toggle_term,
    },
    normal = {
        -- Editing bindings
        ["<Leader>j"] = "J",
        ["U"] = "<C-r>",
        ["<Leader>r"] = lsp.buf.rename,
        ["<Leader>a"] = lsp.buf.code_action,
        ["<Leader>F"] = function() lsp.buf.format{ async = true } end,

        -- Editor bindings
        ["<C-s>"] = utils.autosave,
        ["gd"] = lsp.buf.definition,
        ["gt"] = lsp.buf.type_definition,
        ["gh"] = function() utils.diagnostic_or(lsp.buf.hover) end,
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
        ["<C-t>"] = utils.toggle_term,
        ["<C-\\>"] = "<Cmd>lua vim.o.cursorcolumn = not vim.o.cursorcolumn<CR>",
        ["<Leader>s"] = "<Cmd>split<CR><Cmd>wincmd j<CR>",
        ["<Leader>v"] = "<Cmd>vsplit<CR><Cmd>wincmd l<CR>",
    },
    visual = {
        ["<"] = "<gv",
        [">"] = ">gv",
    },
    terminal = {
        ["<C-t>"] = utils.toggle_term,
        ["<C-h>"] = "<Cmd>wincmd h<CR>",
        ["<C-j>"] = "<Cmd>wincmd j<CR>",
        ["<C-k>"] = "<Cmd>wincmd k<CR>",
        ["<C-l>"] = "<Cmd>wincmd l<CR>",
    },
}
