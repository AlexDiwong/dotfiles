return {
    {
        'williamboman/mason-lspconfig.nvim',
        dependencies = {
            'williamboman/mason.nvim',
            'neovim/nvim-lspconfig',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/nvim-cmp',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'j-hui/fidget.nvim',
        },
        config = function()
            local cmp = require('cmp')
            local cmp_lsp = require('cmp_nvim_lsp')
            local capabilities = vim.tbl_deep_extend(
                'force',
                {},
                vim.lsp.protocol.make_client_capabilities(),
                cmp_lsp.default_capabilities()
            )

            require('fidget').setup({})
            require('mason').setup()
            require('mason-lspconfig').setup({
                ensure_installed = {
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
                },
                handlers = {
                    function(server_name)
                        require('lspconfig')[server_name].setup {
                            capabilities = capabilities
                        }
                    end,

                    ["lua_ls"] = function()
                        local lspconfig = require("lspconfig")
                        lspconfig.lua_ls.setup {
                            settings = {
                                Lua = {
                                    diagnostics = {
                                        globals = { "vim" }
                                    }
                                }
                            }
                        }
                    end,
                }
            })

            cmp.setup({
                snippet = {
                    -- REQUIRED - you must specify a snippet engine
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-p>'] = cmp.mapping.select_prev_item({ behaviour = cmp.SelectBehavior.Select }),
                    ['<C-n>'] = cmp.mapping.select_next_item({ behaviour = cmp.SelectBehavior.Select }),
                    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                    ['<C-Space>'] = cmp.mapping.complete(),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' }, -- For luasnip users.
                }, {
                    { name = 'buffer' },
                })
            })

            vim.diagnostic.config({
                update_in_insert = true,
                float = {
                    focusable = false,
                    style = 'minimal',
                    border = 'rounded',
                    source = 'alwayas',
                    header = '',
                    prefix = '',
                },
            })

            local signs = {
                { name = "DiagnosticSignError", text = "✘" },
                { name = "DiagnosticSignWarn", text = "▲" },
                { name = "DiagnosticSignHint", text = "⚑" },
                { name = "DiagnosticSignInfo", text = "»" },
            }

            for _, sign in ipairs(signs) do
                vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
            end
        end
    }
}
