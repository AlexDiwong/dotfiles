local lsp = require('lsp-zero').preset({})

lsp.ensure_installed({
    -- Replace these with whatever servers you want to install
    'tsserver',
    'eslint',
    'lua_ls',
    'rust_analyzer',
    'golangci_lint_ls',
    'gopls',
    'pyright',
    'html',
    'jsonls',
    'yamlls'
})

local cmp = require('cmp')
local cmp_select = { behaviour = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
})

lsp.setup_nvim_cmp({
    mapping = cmp_mappings,
    -- sources = {
    --     { name = 'path' },
    --     { name = 'nvim_lsp' },
    --     { name = 'buffer',  keyword_length = 3 },
    --     { name = 'luasnip', keyword_length = 2 },
    -- },
})

lsp.set_sign_icons({
    error = '✘',
    warn = '▲',
    hint = '⚑',
    info = '»'
})

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }
    lsp.buffer_autoformat()

    vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

-- (Optional) Configure lua language server for neovim
-- Fix Undefined global 'vim'
require('lspconfig').lua_ls.setup {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    },
    lsp.nvim_lua_ls()
}

lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})
