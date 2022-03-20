local api = vim.api
local fn = vim.fn
local lsp = vim.lsp

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


require("nvim-treesitter.configs").setup{
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
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require("lspconfig").sumneko_lua.setup {
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

require("rust-tools").setup{
    tools = {
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
    },
}

require("luasnip.loaders.from_snipmate").lazy_load()

local luasnip = require("luasnip")
local cmp = require("cmp")
cmp.setup{
    formatting = {
        format = require("lspkind").cmp_format{
            mode = "symbol_text",
            maxwidth = 50,
        },
    },
    mapping = {
        ["<A-k>"] = cmp.mapping.select_prev_item(),
        ["<A-j>"] = cmp.mapping.select_next_item(),
        ["<C-a>"] = cmp.mapping.abort(),
        -- ["<Tab>"] = cmp.mapping.complete(),
        ["<Tab>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
        }),
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    sources = {
        { name = "path" },
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "cmp_tabnine" },
        { name = "buffer" },
        { name = "nvim_lsp_signature_help" },
    },
}

-- Lazily load the crates source
api.nvim_create_autocmd("FileType", {
    pattern = "toml",
    callback = function() require("cmp").setup.buffer{ sources = {{ name = "crates" }}} end,
})

require("cmp_tabnine.config"):setup{
    max_lines = 1024;
    max_num_results = 5;
    sort = true;
    run_on_every_keystroke = true;
    snippet_placeholder = '..';
}

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

