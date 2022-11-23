local api = vim.api
local fn = vim.fn
local lsp = vim.lsp

local esc_per_mode = {
    ["i"] = "<Esc>l",
    ["v"] = "<Esc>",
    ["t"] = "<C-\\><C-n>",
}

require("better_escape").setup{
    mapping = { "jk" },
    clear_empty_lines = true,
    keys = function()
        return esc_per_mode[api.nvim_get_mode()["mode"]]
    end,
}


require("gitsigns").setup{
    signs = {
        add = { text = ' +' },
        change = { text = ' ~' },
        delete = { text = ' _' },
        topdelete = { text = ' ‾' },
        changedelete = { text = ' ~' },
    },
}


local cursor_pos_bg = "#252525"

local onedark = require("onedark")
onedark.setup{
    style = "warm",
    highlights = {
        CursorColumn = { bg = cursor_pos_bg },
        CursorLine = { bg = cursor_pos_bg },
        CursorLineNr = { fg = "#eeeeee" },
        NormalFloat = { bg = "background" },
        FloatBorder = { fg = "#cccccc", bg = "background" },
        IndentLine = { fg = "#444444" },
        GitSignsAdd = { fg = "#33ff55" },
        GitSignsChange = { fg = "#44bbff" },
        GitSignsDelete = { fg = "#ff5566" },
        TSComment = { fg = "#888888" },
    },
}

-- Equivalent of cmd("colorscheme onedark")
onedark.load()


require("indent_blankline").setup{
    show_current_context = true,
    char_highlight_list = {
        "IndentLine",
    },
}


require("lualine").setup{
    options = {
        component_separators = { left = "│", right = ''},
        section_separators = { left = "", right = ''},
        globalstatus = true,
    },
}


require("colorizer").setup(
    {
        "*";
        css = {
            css = true,
        },
    },
    { -- Default options
        RGB = false,
        names = false,
    }
)


local telescope = require("telescope")
telescope.setup{
    defaults = {
        mappings = {
            ["n"] = {
                ["<CR>"] = "select_tab",
                ["<Esc><CR>"] = "select_default", -- Alt + Enter
            },
            ["i"] = {
                ["<CR>"] = "select_tab",
                ["<Esc><CR>"] = "select_default", -- Alt + Enter
            },
        },
    }
}

telescope.load_extension("fzf")


-- WebGPU shading language support
api.nvim_create_autocmd("BufRead,BufNewFile", {
    pattern = "*.wgsl",
    callback = function() vim.bo.filetype = "wgsl" end,
})

require("nvim-treesitter.parsers").get_parser_configs().wgsl = {
    install_info = {
        url = "https://github.com/szebniok/tree-sitter-wgsl",
        files = { "src/parser.c" },
    },
}

require("nvim-treesitter.configs").setup{
    ensure_installed = { "rust", "toml", "lua", "wgsl", "c", "cpp" },
    highlight = {
        enable = true,
    },
    indent = {
        enable = true,
    },
}


require("fidget").setup{
    text = {
        spinner = "dots",
    }
}


local capabilities = lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local lspconfig = require("lspconfig")

lspconfig.clangd.setup{
    capabilities = capabilities,
}

lspconfig.sumneko_lua.setup {
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
                path = runtime_path,
            },
            diagnostics = {
                globals = {
                    "vim",
                    "use",
                    "toggle_term",
                    "reset_start_opts",
                    "diagnostic_or_hover",
                    "autosave",
                    "clippy",
                    "map",
                },
            },
            workspace = {
                library = api.nvim_get_runtime_file("", true),
            },
            telemetry = {
                enable = false,
            },
        },
    },
}

local rust_tools = require("rust-tools")
local utils = require("utils")
rust_tools.setup{
    tools = {
        runnables = {
            use_telescope = true,
        },
        hover_actions = {
            auto_focus = true,
        },
    },
    server = {
        capabilities = capabilities,
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
            utils.map{
                normal = {
                    ["gh"] = { function() utils.diagnostic_or(rust_tools.hover_actions.hover_actions) end, { buffer = bufnr } },
                },
            }
        end,
    },
}

local luasnip = require("luasnip")
luasnip.config.set_config {
    updateevents = "TextChanged,TextChangedI",
}

local cmp = require("cmp")
cmp.setup{
    formatting = {
        format = require("lspkind").cmp_format{
            mode = "symbol_text",
            maxwidth = 50,
        },
    },
    mapping = {
        ["<A-k>"] = cmp.mapping.select_prev_item{ behavior = cmp.SelectBehavior.Select },
        ["<A-j>"] = cmp.mapping.select_next_item{ behavior = cmp.SelectBehavior.Select },
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.confirm {
                    behavior = cmp.ConfirmBehavior.Insert,
                    select = true,
                }
            elseif luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    sources = {
        { name = "path" },
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "luasnip" },
        { name = "nvim_lsp_signature_help" },
    },
}

-- Lazily load the crates source
api.nvim_create_autocmd("FileType", {
    pattern = "toml",
    callback = function() require("cmp").setup.buffer{ sources = {{ name = "crates" }}} end,
})

-- Set borders for floating windows
local orig_util_open_floating_preview = lsp.util.open_floating_preview
function lsp.util.open_floating_preview(contents, syntax, opts, ...)
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

-- Change diagnostic icons in the gutter
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Built-in diagnostic settings
vim.diagnostic.config{
    severity_sort = true,
    update_in_insert = true,
}
