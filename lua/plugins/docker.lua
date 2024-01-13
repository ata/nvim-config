return {
    "crnvl96/lazydocker.nvim",
    event = "VeryLazy",
    dependencies = {
        "MunifTanjim/nui.nvim",
    },
    opts = {},
    keys = {
        { "<leader>ld", ":LazyDocker<cr>", desc = "Open LazyDocker" },
    },
}
