return {
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
    dependencies = {
        'nvim-lua/plenary.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make'
        },
    },
    config = function()
        require("telescope").setup {
            extensions = {
                fzf = {
                    fuzzy = true,                    -- false will only do exact matching
                    override_generic_sorter = true,  -- override the generic sorter
                    override_file_sorter = true,     -- override the file sorter
                    case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                    -- the default case_mode is "smart_case"
                }
            }
        }
        require('telescope').load_extension('fzf')

        -- Set keymap
        local builtin = require('telescope.builtin')
        local map  = vim.keymap.set
        map('n', '<leader>ff', builtin.find_files, { desc = "Find files" })
        map('n', '<leader>fg', builtin.live_grep, { desc="Live Grep" })
        map('n', '<leader>fb', builtin.buffers, { desc= "Find in buffers" })
        map('n', '<leader>fh', builtin.help_tags, { desc ="Help tags" })

    end
}
