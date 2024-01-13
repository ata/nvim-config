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

        end,
    }
}
