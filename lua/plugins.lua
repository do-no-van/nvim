local api = vim.api
local cmd = vim.cmd

-- Auto-install plugins on save
api.nvim_create_autocmd("BufWritePost", {
    pattern = "plugins.lua",
    command = "PackerSync",
})

cmd("packadd packer.nvim")
require("packer").startup{function()
        -- Packer manages itself
        use "wbthomason/packer.nvim"

        -- Functionality
        use {
            "nvim-treesitter/nvim-treesitter",
            run = ":TSUpdate",
        }
        use "nathom/filetype.nvim"
        use "jiangmiao/auto-pairs"
        use "tpope/vim-commentary"
        use "tpope/vim-surround"
        use "nvim-lua/popup.nvim"
        use "nvim-lua/plenary.nvim"
        use "lewis6991/gitsigns.nvim"

        -- Aesthetics
        use "romainl/vim-cool"
        use "norcalli/nvim-colorizer.lua"
        use "navarasu/onedark.nvim"
        use {
            "kyazdani42/nvim-web-devicons",
            config = function() require("nvim-web-devicons").setup{} end,
        }
        use "nvim-lualine/lualine.nvim"
        use "lukas-reineke/indent-blankline.nvim"

        -- File browser
        use "nvim-telescope/telescope.nvim"
        use {
            "nvim-telescope/telescope-fzf-native.nvim",
            run = "make",
        }

        -- Lsp + auto-completion
        use "j-hui/fidget.nvim"
        use "neovim/nvim-lspconfig"
        use "onsails/lspkind-nvim"
        use "L3MON4D3/LuaSnip"
        use "saadparwaiz1/cmp_luasnip"
        use "hrsh7th/nvim-cmp"
        use "hrsh7th/cmp-nvim-lsp"
        use "hrsh7th/cmp-buffer"
        use "hrsh7th/cmp-path"
        use "hrsh7th/cmp-nvim-lsp-signature-help"
        use "simrat39/rust-tools.nvim"
        use {
            "tzachar/cmp-tabnine",
            run = "./install.sh",
        }
        use {
            "saecki/crates.nvim",
            event = { "BufRead Cargo.toml" },
            config = function() require("crates").setup() end,
        }
    end,
    config = {
        display = {
            open_fn = function()
                return require("packer.util").float({ border = "single" })
            end
        },
    },
}
