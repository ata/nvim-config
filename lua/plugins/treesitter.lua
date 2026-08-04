-- nvim-treesitter `main` branch (required for Neovim 0.12).
-- The old `master` branch is locked to Neovim <= 0.11; its query directives
-- (e.g. `set-lang-from-info-string!`) crash on 0.12 because query matches now
-- hold *lists* of nodes.
--
-- On `main` the plugin only installs parsers/queries: highlighting, indentation
-- and folding are enabled per-buffer through Neovim's own treesitter API.

local ensure_installed = {
    "bash",
    "css",
    "dockerfile",
    "gitignore",
    "go",
    "graphql",
    "html",
    "javascript",
    "json",
    "lua",
    "markdown",
    "markdown_inline",
    "prisma",
    "query",
    "svelte",
    "tsx",
    "typescript",
    "vim",
    "yaml",
}

-- Filetypes to leave on regex syntax highlighting.
local highlight_disabled = { dockerfile = true }

-- Minimal stand-in for the `incremental_selection` module, which no longer
-- exists on the `main` branch. <C-space> grows the selection to the enclosing
-- node, <bs> steps back down.
local select_stack = {}

local function apply_range(buf, range)
    local srow, scol, erow, ecol = unpack(range)
    if ecol == 0 and erow > srow then
        erow = erow - 1
        ecol = #vim.api.nvim_buf_get_lines(buf, erow, erow + 1, true)[1]
    end
    vim.fn.setpos("'<", { buf, srow + 1, scol + 1, 0 })
    vim.fn.setpos("'>", { buf, erow + 1, math.max(ecol, 1), 0 })
    vim.cmd("normal! gv")
end

local function current_range(buf)
    local mode = vim.fn.mode()
    if mode == "v" or mode == "V" or mode == "\22" then
        local a, b = vim.fn.getpos("v"), vim.fn.getpos(".")
        if a[2] > b[2] or (a[2] == b[2] and a[3] > b[3]) then
            a, b = b, a
        end
        return { a[2] - 1, a[3] - 1, b[2] - 1, b[3] }, false
    end
    local cursor = vim.api.nvim_win_get_cursor(0)
    select_stack[buf] = {}
    return { cursor[1] - 1, cursor[2], cursor[1] - 1, cursor[2] + 1 }, true
end

local function grow_selection()
    local buf = vim.api.nvim_get_current_buf()
    local range, fresh = current_range(buf)
    local srow, scol, erow, ecol = unpack(range)

    -- `get_node` does not parse on its own, and the highlighter parses
    -- asynchronously, so make sure the region is available first.
    local ok, parser = pcall(vim.treesitter.get_parser, buf)
    if not ok or not parser then
        return
    end
    parser:parse({ srow, erow + 1 })

    local node = vim.treesitter.get_node({ bufnr = buf, pos = { srow, scol } })
    if not node then
        return
    end

    -- Walk up until we find a node that covers strictly more than the selection.
    while node do
        local ns, nsc, ne, nec = node:range()
        local wider = ns < srow or (ns == srow and nsc < scol)
        local longer = ne > erow or (ne == erow and nec > ecol)
        if wider or longer then
            break
        end
        node = node:parent()
    end
    if not node then
        return
    end

    if not fresh then
        select_stack[buf] = select_stack[buf] or {}
        table.insert(select_stack[buf], range)
    end
    apply_range(buf, { node:range() })
end

local function shrink_selection()
    local buf = vim.api.nvim_get_current_buf()
    local stack = select_stack[buf]
    if not stack or #stack == 0 then
        return
    end
    apply_range(buf, table.remove(stack))
end

return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        -- `main` does not support lazy-loading.
        lazy = false,
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter").setup({})
            require("nvim-treesitter").install(ensure_installed)

            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup("treesitter_start", { clear = true }),
                callback = function(args)
                    local ft = vim.bo[args.buf].filetype
                    if highlight_disabled[ft] then
                        return
                    end

                    -- `get_lang` falls back to the filetype itself, so the
                    -- parser has to be confirmed separately. `language.add`
                    -- returns `nil, err` when there is none (e.g. for scratch
                    -- filetypes like `TelescopePrompt`).
                    local lang = vim.treesitter.language.get_lang(ft)
                    if not lang then
                        return
                    end
                    local ok, added = pcall(vim.treesitter.language.add, lang)
                    if not ok or not added then
                        return
                    end

                    vim.treesitter.start(args.buf, lang)

                    -- Keep the native indentexpr for languages without an
                    -- `indents` query.
                    if vim.treesitter.query.get(lang, "indents") then
                        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                    end
                end,
            })

            vim.keymap.set({ "n", "x" }, "<C-space>", grow_selection, { desc = "Grow treesitter selection" })
            vim.keymap.set("x", "<bs>", shrink_selection, { desc = "Shrink treesitter selection" })
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = {},
    },

    {
        "windwp/nvim-ts-autotag",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = {},
    },

    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        init = function()
            -- The legacy nvim-treesitter module hook is gone on `main`.
            vim.g.skip_ts_context_commentstring_module = true
        end,
        config = function()
            require("ts_context_commentstring").setup({})
        end,
    },
}
