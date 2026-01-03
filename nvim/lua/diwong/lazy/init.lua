return {
    "folke/tokyonight.nvim",
    'nvim-lua/plenary.nvim',
    'mbbill/undotree',
    'andreshazard/vim-freemarker',
    {
        'tpope/vim-fugitive',
        config = function()
            vim.keymap.set("n", "<leader>gs", vim.cmd.Git);
            vim.keymap.set("n", "<leader>gy", ":.GBrowse!<CR>");
            vim.keymap.set("n", "<leader>go", ":.GBrowse<CR>");
        end
    },
    {
        'shumphrey/fugitive-gitlab.vim',
        dependencies = {
            'tpope/vim-fugitive'
        }
    },
    {
        'numToStr/Comment.nvim',
        opts = {
            -- add any options here
        },
        lazy = false,
        config = function()
            require('Comment').setup()
        end
    },

}
