return {
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            local gs = require('gitsigns')
            gs.setup()


            local function map(mode, l, r, opts)
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, l, r, opts)
            end

            -- Navigation
            map('n', ']c', function()
                if vim.wo.diff then return ']c' end
                vim.schedule(function() gs.next_hunk() end)
                return '<Ignore>'
            end, { expr = true })

            map('n', '[c', function()
                if vim.wo.diff then return '[c' end
                vim.schedule(function() gs.prev_hunk() end)
                return '<Ignore>'
            end, { expr = true })

            -- Actions
            map('n', '<leader>gs', gs.stage_hunk, { desc = "Git: Stage the hunk at the cursor position" })
            map('n', '<leader>gr', gs.reset_hunk, { desc = "Git: Reset the lines of the hunk at the cursor position" })
            map('v', '<leader>gs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
                { desc = "Git: Stage the hunk at the cursor position on visual mode" })
            map('v', '<leader>gr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
                { desc = "Git: Reset the lines of the hunk at the cursor position on visual mode" })
            map('n', '<leader>gS', gs.stage_buffer, { desc = "Git: Stage all hunks in current buffer" })
            map('n', '<leader>gu', gs.undo_stage_hunk, { desc = "Git: Undo the last call of stage_hunk" })
            map('n', '<leader>gR', gs.reset_buffer, { desc = "Git: Reset the lines of all hunks in the buffer" })
            map('n', '<leader>gp', gs.preview_hunk,
                { desc = "Git: Preview the hunk at the cursor position in a floating window" })
            map('n', '<leader>gb', function() gs.blame_line { full = true } end, { desc = "Git: Blame line" })
            map('n', '<leader>gtb', gs.toggle_current_line_blame, { desc = "Git: Toggle curret line blame" })
            map('n', '<leader>gtd', gs.toggle_deleted, { desc = "Git: Toggle delete" })

            map('n', '<leader>gd', gs.diffthis, { desc = "Git: Diff This" })
            map('n', '<leader>gD', function() gs.diffthis('~') end, { desc = "Git: Diff This" })

            -- Text object
            map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        end
    },
}
