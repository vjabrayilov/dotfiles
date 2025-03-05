return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
    },

    config = function()
        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())

        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "ruff",
                "rust_analyzer",
                "clangd",
            },
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,
                ["rust_analyzer"] = function()
                    -- local lspconfig = require("lspconfig")
                    -- lspconfig.rust_analyzer.setup {
                    --     capabilities = capabilities,
                    --     settings = {
                    --         ["rust-analyzer"] = {
                    --             cargo = {
                    --                 allFeatures = true,
                    --             },
                    --             imports = {
                    --                 group = {
                    --                     enable = false,
                    --                 },
                    --             },
                    --             completion = {
                    --                 postfix = {
                    --                     enable = false,
                    --                 },
                    --             },
                    --         },
                    --     },
                    -- }
                end,

                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim", "it", "describe", "before_each", "after_each" },
                                }
                            }
                        }
                    }
                end,
                ["ruff"] = function()
                    local lspconfig = require("lspconfig")
                    local configs = require 'lspconfig.configs'
                    if not configs.ruff_lsp and vim.fn.executable('ruff-lsp') == 1 then
                        configs.ruff_lsp = {
                            default_config = {
                                cmd = { 'ruff-lsp' },
                                filetypes = { 'python' },
                                root_dir = require('lspconfig').util.find_git_ancestor,
                                init_options = {
                                    settings = {
                                        args = {}
                                    }
                                }
                            }
                        }
                    end
                    if configs.ruff_lsp then
                        lspconfig.ruff_lsp.setup {}
                    end
                end,

            }
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' }, -- For luasnip users.
            }, {
                { name = 'buffer' },
            })
        })

        vim.diagnostic.config({
            -- update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end
}
