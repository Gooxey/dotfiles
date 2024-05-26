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
    { "ellisonleao/gruvbox.nvim", priority = 1000 , config = true },

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
    { "lewis6991/gitsigns.nvim", config = true },
    "RRethy/vim-illuminate",

    -- other
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    {'akinsho/toggleterm.nvim', version = "*", config = true },
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.6',
        dependencies = { 'nvim-lua/plenary.nvim' },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-context",
        },
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
    {
        "https://github.com/ms-jpq/coq_nvim",
        build = ":COQdeps",
        dependencies = {
            "ms-jpq/coq.artifacts", -- 9000+ Snippets
        },
    },
})
