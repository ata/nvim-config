return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = function()
        require("neo-tree").setup {}
        local map = vim.keymap.set
        map('n', '<leader>ee', ":Neotree<cr>", { desc = "Find file in exporer" })
        map('n', '<leader>ef', ":Neotree reveal<cr>", { desc = "Find file in exporer" })
    end
}
