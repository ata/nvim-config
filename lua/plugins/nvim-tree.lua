return {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require("nvim-tree").setup {}

        -- Keymaps
        local map  = vim.keymap.set
        local api = require("nvim-tree.api")

        map('n', '<leader>ee', api.tree.toggle, { desc = "Toggle Exporer" })
        map('n', '<leader>ef', api.tree.find_file, { desc = "Find file in exporer" })
    end
}
