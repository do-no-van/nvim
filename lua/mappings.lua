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
        ["jk"] = "<Esc>l",
        ["<S-Tab>"] = "<C-d>",
        ["<C-c>"] = '"+y',
        ["<C-h>"] = "<Cmd>wincmd h<CR>",
        ["<C-j>"] = "<Cmd>wincmd j<CR>",
        ["<C-k>"] = "<Cmd>wincmd k<CR>",
        ["<C-l>"] = "<Cmd>wincmd l<CR>",
        ["<C-t>"] = "<Cmd>lua require('utils').toggle_term()<CR>",
    },
    normal = {
        -- Editing bindings
        ["<Leader>j"] = "J",
        ["U"] = "<C-r>",
        ["<Leader>r"] = "<Cmd>lua vim.lsp.buf.rename()<CR>",
        ["<Leader>a"] = "<Cmd>lua vim.lsp.buf.code_action()<CR>",
        ["<Leader>F"] = "<Cmd>lua vim.lsp.buf.formatting()<CR>",

        -- Editor bindings
        ["<Leader>l"] = "<Cmd>lua require('cargo_clippy').clippy()<CR>",
        ["<Leader>L"] = "<Cmd>lua require('cargo_clippy').clear()<CR>",
        ["<C-s>"] = "<Cmd>lua require('utils').autosave()<CR>",
        ["gd"] = "<Cmd>lua vim.lsp.buf.definition()<CR>",
        ["gt"] = "<Cmd>lua vim.lsp.buf.type_definition()<CR>",
        ["gh"] = "<Cmd>lua require('utils').diagnostic_or_hover()<CR>",
        ["gE"] = "<Cmd>lua vim.diagnostic.goto_prev()<CR>",
        ["ge"] = "<Cmd>lua vim.diagnostic.goto_next()<CR>",
        ["<Leader>,"] = "<Cmd>tabprevious<CR>",
        ["<Leader>."] = "<Cmd>tabnext<CR>",
        ["<Leader><"] = "<Cmd>tabmove -1<CR>",
        ["<Leader>>"] = "<Cmd>tabmove +1<CR>",
        ["<Leader>c"] = "<Cmd>quit!<CR>",
        ["<Leader>w"] = "<Cmd>wall!<CR>",
        ["<Leader>e"] = "<Cmd>x!<CR>",
        ["<Leader>f"] = "<Cmd>Telescope find_files<CR>",
        ["<Leader>g"] = "<Cmd>Telescope live_grep<CR>",
        ["<C-t>"] = "<Cmd>lua require('utils').toggle_term()<CR>",
        ["<C-\\>"] = "<Cmd>lua vim.o.cursorcolumn = not vim.o.cursorcolumn<CR>",
        ["<Leader>s"] = "<Cmd>split<CR><Cmd>wincmd j<CR>",
        ["<Leader>v"] = "<Cmd>vsplit<CR><Cmd>wincmd l<CR>",
    },
    visual = {
        ["jk"] = "<Esc>",
        ["<"] = "<gv",
        [">"] = ">gv",
    },
    terminal = {
        ["jk"] = "<C-\\><C-n>",
        ["<C-t>"] = "<Cmd>lua require('utils').toggle_term()<CR>",
        ["<C-h>"] = "<Cmd>wincmd h<CR>",
        ["<C-j>"] = "<Cmd>wincmd j<CR>",
        ["<C-k>"] = "<Cmd>wincmd k<CR>",
        ["<C-l>"] = "<Cmd>wincmd l<CR>",
    },
}

