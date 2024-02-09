return {
    {
        "williamboman/mason.nvim",
        opts = {
            PATH = 'append'
        },
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup {
                ensure_installed = {
                    "lua_ls",
                    "solargraph",
                    "pyright",
                    "ruff_lsp",
                    "gopls",
                    "dockerls",
                    "docker_compose_language_service",
                    "sqlls",
                    "helm_ls",
                    "clangd",
                    "groovyls",
                    "rust_analyzer",
                }
            }
        end
    },
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            { "antosha417/nvim-lsp-file-operations", config = true },
        },
        config = function()
            local lspconfig = require("lspconfig")
            local cmp_nvim_lsp = require("cmp_nvim_lsp")

            local keymap = vim.keymap -- for conciseness
            local opts = { noremap = true, silent = true }
            local on_attach = function(client, bufnr)
                opts.buffer = bufnr

                -- set keybinds
                opts.desc = "Show LSP references"
                keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

                opts.desc = "Go to declaration"
                keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

                opts.desc = "Show LSP definitions"
                keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

                opts.desc = "Show LSP implementations"
                keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

                opts.desc = "Show LSP type definitions"
                keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

                opts.desc = "See available code actions"
                keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

                opts.desc = "Smart rename"
                keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

                opts.desc = "Show buffer diagnostics"
                keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

                opts.desc = "Show line diagnostics"
                keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

                opts.desc = "Go to previous diagnostic"
                keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

                opts.desc = "Go to next diagnostic"
                keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

                opts.desc = "Show documentation for what is under cursor"
                keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

                opts.desc = "Restart LSP"
                keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
            end

            local cmp_capabilities = cmp_nvim_lsp.default_capabilities()
            lspconfig.lua_ls.setup {
                capabilities = cmp_capabilities,
                on_attach = on_attach,
                settings = {
                    Lua = {
                        -- make the language server recognize "vim" global
                        diagnostics = {
                            globals = { "vim" },
                        },
                        workspace = {
                            -- make language server aware of runtime files
                            library = {
                                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                                [vim.fn.stdpath("config") .. "/lua"] = true,
                            },
                        },
                    },
                },

            }
            lspconfig.solargraph.setup {
                capabilities = cmp_capabilities,
                on_attach = on_attach,
            }
            lspconfig.pyright.setup {
                capabilities = cmp_capabilities,
                on_attach = on_attach,
            }
            lspconfig.ruff_lsp.setup {
                on_attach = function(client, bufnr)
                    -- Disable hover in favor of Pyright
                    client.server_capabilities.hoverProvider = false
                end
            }
            lspconfig.gopls.setup {
                capabilities = cmp_capabilities,
                on_attach = on_attach,
            }
            lspconfig.dockerls.setup {
                capabilities = cmp_capabilities,
                on_attach = on_attach,
            }
            lspconfig.docker_compose_language_service.setup {
                capabilities = cmp_capabilities,
                on_attach = on_attach,
            }
            lspconfig.sqlls.setup {
                capabilities = cmp_capabilities,
                on_attach = on_attach,
            }
            lspconfig.helm_ls.setup {
                capabilities = cmp_capabilities,
                on_attach = on_attach,
                settings = {
                    ['helm-ls'] = {
                        yamlls = {
                            path = "yaml-language-server",
                        }
                    }
                }
            }
            lspconfig.clangd.setup {
                capabilities = cmp_capabilities,
                on_attach = on_attach,
            }

            lspconfig.groovyls.setup {
                capabilities = cmp_capabilities,
                on_attach = on_attach,
            }

            lspconfig.rust_analyzer.setup {
                capabilities = cmp_capabilities,
                on_attach = on_attach,
            }

            -- Auto Format only for some extensions
            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = { "*.lua", "*.py", "*.go" },
                buffer = buffer,
                callback = function()
                    vim.lsp.buf.format { async = false }
                end
            })
            -- Manual Format on demand
            vim.keymap.set("n", "<leader>F", vim.lsp.buf.format, { desc = "Format by LSP" })
        end,
    }
}
