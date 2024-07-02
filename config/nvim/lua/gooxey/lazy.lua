-- install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- install plugins
require("lazy").setup({
    -- colorscheme
    { "ellisonleao/gruvbox.nvim", priority = 1000, config = true },

    -- quality of life
    "pocco81/auto-save.nvim",
    {
        'numToStr/Comment.nvim',
        lazy = false,
        config = true
    },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
    },

    -- visual
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" }
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {},
        config = true
    },
    { "lewis6991/gitsigns.nvim",  config = true },
    "RRethy/vim-illuminate",

    -- other
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    { 'akinsho/toggleterm.nvim', version = "*", config = true },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.6',
        dependencies = { 'nvim-lua/plenary.nvim' },
    },
    {
        'stevearc/oil.nvim',
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = true,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
    },
    {
        "NeogitOrg/neogit",
        branch = "master",
        config = true,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        }
    },

    -- lsp
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "nickel-lang/vim-nickel",
        },
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lsp",
            "saadparwaiz1/cmp_luasnip",
            {
                "L3MON4D3/LuaSnip",
                version = "v2.*",
                dependencies = { "rafamadriz/friendly-snippets" },
            }
        },
    },

    --     rust
    {
        'mrcjkb/rustaceanvim',
        version = '^4', -- Recommended
        lazy = false, -- This plugin is already lazy
    },
    {
        'saecki/crates.nvim',
        tag = 'stable',
        event = { "BufRead Cargo.toml" }, -- for lazy loading
        config = function()
            require('crates').setup()
        end,
    },

    --     haskell
    {
        'mrcjkb/haskell-tools.nvim',
        version = '^3', -- Recommended
        lazy = false, -- This plugin is already lazy
    },
})
