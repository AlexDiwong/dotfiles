return {
    "folke/tokyonight.nvim",
    'nvim-lua/plenary.nvim',
    'mbbill/undotree',
    {
        'tpope/vim-fugitive',
        config = function ()
            vim.keymap.set("n", "<leader>gs", vim.cmd.Git);
        end
    },
}
