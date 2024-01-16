return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
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
                }
            }
        end
    },
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local lspconfig = require("lspconfig")

            lspconfig.lua_ls.setup {}
            lspconfig.solargraph.setup {}
            lspconfig.pyright.setup {}
            lspconfig.ruff_lsp.setup {
                on_attach = function(client, bufnr)
                    -- Disable hover in favor of Pyright
                    client.server_capabilities.hoverProvider = false
                end
            }
            lspconfig.gopls.setup {}
            lspconfig.dockerls.setup {}
            lspconfig.docker_compose_language_service.setup {}
            lspconfig.sqlls.setup {}
            lspconfig.helm_ls.setup {}

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
