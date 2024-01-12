return {
    "godlygeek/tabular",
    "mg979/vim-visual-multi",
    {
        "echasnovski/mini.comment",
        event = "VeryLazy",
        opts = {
            options = {
                custom_commentstring = function()
                    return vim.bo.commentstring
                end,
            },
        },
    },
    {
        "ntpeters/vim-better-whitespace",
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {},
    }
}
