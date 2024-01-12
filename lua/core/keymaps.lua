local map = vim.keymap.set

-- Mapping the jumping between splits. Hold control while using vim nav.
map("n", "<C-J>", "<C-W>j")
map("n", "<C-K>", "<C-W>k")
map("n", "<C-H>", "<C-W>h")
map("n", "<C-L>", "<C-W>l")

-- Tab Navigation
map("n", "<leader><tab>l", ":tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>f", ":tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab><tab>", ":tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>]", ":tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>d", ":tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader><tab>[", ":tabprevious<cr>", { desc = "Previous Tab" })

-- buffer resizing mappings (shift + arrow key)
map("n", "<S-Up>", "<c-w>-")
map("n", "<S-Down>", "<c-w>+")
map("n", "<S-Left>", "<c-w><<c-w><<c-w><")
map("n", "<S-Right>", "<c-w>><c-w>><c-w>>")

-- Quiting
map("n", "<leader>qq", ":qa!<cr>", { desc="Quit All" })
map("n", "<leader>qa", ":qa!<cr>", { desc="Quit All" })
map("n", "<leader>qw", ":wqall<cr>", { desc="Quit All And Save" })

-- Editing
map("n", "<Leader>w", ":set wrap!<cr>", { desc = "Wrap Line"})
map("n", "Y","y$", { desc="Yank from the cursor to the end of the line" })
map("n", "vv","`[V`]", { desc="select the lines which were just pasted" })
-- map("n", "<Leader>e", ":s/\\v(\\S+)\\s+/\\1 /<cr>:nohl<cr>", { desc="compress excess whitespace on current line" })
map("n", "<Leader>d", ":bufdo bd<cr>", { desc="delete all buffers" })
map("n", "<Leader><space>", ":StripWhitespace<cr>", { desc="clean up trailing whitespace" })
map("n", "<Leader>c", ":noh<cr>", { desc="spacebar to clear search highlight" })
map("n", "<Leader>I", "gg=G``<cr>", { desc="reindent the entire file" })

local builtin = require('telescope.builtin')
map('n', '<leader>ff', builtin.find_files, { desc = "Find files" })
map('n', '<leader>fg', builtin.live_grep, { desc="Live Grep" })
map('n', '<leader>fb', builtin.buffers, { desc= "Find in buffers" })
map('n', '<leader>fh', builtin.help_tags, { desc ="Help tags" })

-- NvimTree keymap

map('n', '<leader>e', ":NvimTreeFindFileToggle<cr>", { desc = "Find files" })
