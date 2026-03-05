return {
    {
        "mason-org/mason.nvim",
        opts = {
            PATH = 'append'
        },
    },
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "lua_ls",
                "solargraph",
                "pyright",
                "ruff",
                "gopls",
                "dockerls",
                "docker_compose_language_service",
                "sqlls",
                "helm_ls",
                "clangd",
                "groovyls",
                "rust_analyzer",
            },
            automatic_enable = true,
        },

        dependencies = {
            {
                "mason-org/mason.nvim", opts = {}
            },
            "neovim/nvim-lspconfig",
        },
    },
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            { "antosha417/nvim-lsp-file-operations", config = true },
        },
        config = function()
            local cmp_nvim_lsp = require("cmp_nvim_lsp")

            local keymap = vim.keymap
            local opts = { noremap = true, silent = true }
            local on_attach = function(client, bufnr)
                opts.buffer = bufnr

                opts.desc = "Show LSP references"
                keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

                opts.desc = "Go to declaration"
                keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

                opts.desc = "Show LSP definitions"
                keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

                opts.desc = "Show LSP implementations"
                keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

                opts.desc = "Show LSP type definitions"
                keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

                opts.desc = "See available code actions"
                keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

                opts.desc = "Smart rename"
                keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

                opts.desc = "Show buffer diagnostics"
                keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

                opts.desc = "Show line diagnostics"
                keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

                opts.desc = "Go to previous diagnostic"
                keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

                opts.desc = "Go to next diagnostic"
                keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

                opts.desc = "Show documentation for what is under cursor"
                keymap.set("n", "K", vim.lsp.buf.hover, opts)

                opts.desc = "Restart LSP"
                keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
            end

            local cmp_capabilities = cmp_nvim_lsp.default_capabilities()

            -- Global defaults for all servers
            vim.lsp.config('*', {
                capabilities = cmp_capabilities,
                on_attach = on_attach,
            })

            -- Per-server overrides
            vim.lsp.config('lua_ls', {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                        workspace = {
                            library = {
                                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                                [vim.fn.stdpath("config") .. "/lua"] = true,
                            },
                        },
                    },
                },
            })

            vim.lsp.config('ruff', {
                on_attach = function(client, bufnr)
                    -- Disable hover in favor of Pyright
                    client.server_capabilities.hoverProvider = false
                end
            })

            vim.lsp.config('helm_ls', {
                on_attach = function(client, bufnr)
                    on_attach(client, bufnr)
                    client.server_capabilities.documentFormattingProvider = false
                    client.server_capabilities.documentRangeFormattingProvider = false
                end,
                settings = {
                    ['helm-ls'] = {
                        yamlls = {
                            path = "yaml-language-server",
                        }
                    }
                }
            })

            -- Auto Format only for some extensions
            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = { "*.lua", "*.py", "*.go" },
                callback = function()
                    vim.lsp.buf.format { async = false }
                end
            })
            -- Manual Format on demand
            vim.keymap.set("n", "<leader>F", vim.lsp.buf.format, { desc = "Format by LSP" })
        end,
    }
}
