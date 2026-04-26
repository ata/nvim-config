return {
    "OXY2DEV/markview.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons"
    },
    ft = { "markdown" },
    keys = {
        { "<leader>mp", "<Cmd>Markview toggle<CR>", desc = "Toggle Markdown Render" },
    },
    opts = {},
}
