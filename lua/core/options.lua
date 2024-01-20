-----------------------------------------------------------
-- General Neovim settings and configuration
-----------------------------------------------------------

-- Default options are not included
-- See: https://neovim.io/doc/user/vim_diff.html
-- [2] Defaults - *nvim-defaults*

local g = vim.g     -- Global variables
local opt = vim.opt -- Set options (global/buffer/windows-scoped)
local cmd = vim.cmd

-----------------------------------------------------------
-- General
-----------------------------------------------------------
opt.mouse = 'a'                               --  Enable mouse support
opt.clipboard = 'unnamedplus'                 --  Copy/paste to system clipboard
opt.swapfile = false                          --  Don't use swapfile
opt.completeopt = 'menuone,noinsert,noselect' --  Autocomplete options

-----------------------------------------------------------
-- UI
-----------------------------------------------------------
opt.number = true           --  Show line number
opt.numberwidth = 2         --  .
opt.showmatch = true        --  Highlight matching parenthesis
opt.foldmethod = 'marker'   --  Enable folding (default 'foldmarker')
opt.colorcolumn = '80'      -- Line lenght marker at 80 columns
opt.splitright = true       --  Vertical split to the right
opt.splitbelow = true       --  Horizontal split to the bottom
opt.ignorecase = true       --  Ignore case letters when search
opt.smartcase = true        --  Ignore lowercase for the whole pattern
opt.linebreak = true        --  Wrap on word boundary
opt.termguicolors = true    --  Enable 24-bit RGB colors
opt.laststatus = 3          --  Set global statusline
opt.showcmd = true          --  show commands as we type them
opt.scrolloff = 4           --  scroll the window when we get near the edge
opt.sidescrolloff = 10      --  scroll the window when we get near the edge
opt.cursorline = true       --  .
opt.ruler = true            --  show current line info (current/total)
opt.rulerformat = '%=%l/%L' -- Format ruler
opt.display = 'lastline'    -- When lines are  ropped at the screen bottom, show as much as possible
cmd.colorscheme "catppuccin"
-----------------------------------------------------------
-- Search and Replace
-----------------------------------------------------------
opt.incsearch = true
opt.hlsearch = true
opt.ignorecase = true -- searching is case insensitive when all lowercase
opt.smartcase = true  -- searching is case insensitive when all lowercase

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
opt.expandtab = true            --  Use spaces instead of tabs
opt.shiftwidth = 4              --  Shift 2 spaces when tab
opt.tabstop = 4                 --  1 tab == 2 spaces
opt.softtabstop = 4             --  Use 4 space as tabs
opt.autoindent = true           --  Match indentation of previous line
opt.smartindent = true          --  Autoindent new lines
cmd.filetype 'on'               -- Detect file plugin
cmd.filetype "plugin indent on" --  perform autoindenting based on filetype plugin


-----------------------------------------------------------
-- Memory, CPU
-----------------------------------------------------------
opt.hidden = true     -- Enable background buffers
opt.history = 100     -- Remember N lines in history
opt.lazyredraw = true -- Faster scrolling
opt.synmaxcol = 240   -- Max column for syntax highlight
opt.updatetime = 250  -- ms to wait for trigger an event

-----------------------------------------------------------
-- Startup
-----------------------------------------------------------
-- Disable nvim intro
opt.shortmess:append "sI"

-- -- Disable builtin plugins
local disabled_built_ins = {
	"2html_plugin",
	"getscript",
	"getscriptPlugin",
	"gzip",
	"logipat",
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
	"matchit",
	"tar",
	"tarPlugin",
	"rrhelper",
	"spellfile_plugin",
	"vimball",
	"vimballPlugin",
	"zip",
	"zipPlugin",
	"tutor",
	"rplugin",
	"synmenu",
	"optwin",
	"compiler",
	"bugreport",
	"ftplugin",
}

for _, plugin in pairs(disabled_built_ins) do
	g["loaded_" .. plugin] = 1
end
