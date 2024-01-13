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
                ensure_installed = { "lua_ls", "solargraph", "pyright", "gopls" }
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
            lspconfig.gopls.setup {}

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
