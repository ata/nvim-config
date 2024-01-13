return {
    "crnvl96/lazydocker.nvim",
    event = "VeryLazy",
    dependencies = {
        "MunifTanjim/nui.nvim",
    },
    opts = {}, -- automatically calls `require("lazydocker").setup()`
    keys = {
        { "<leader>ld", ":LazyDocker<cr>", desc = "Open LazyDocker" },
    },
}
