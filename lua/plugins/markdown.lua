return {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    keys = {
        { "<leader>mp", ":MarkdownPreview<cr>", desc = "Open MarkdownPreview" }
    },
    build = function()
        vim.fn["mkdp#util#install"]()
    end,
}
