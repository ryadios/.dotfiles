-- ╭─────────────────────────────────────────────────────────╮
-- │                        Markdown                         │
-- ╰─────────────────────────────────────────────────────────╯

return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = "markdown",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {
            -- Disable rendering in LSP hover / scratch floats (buftype = "nofile")
            overrides = {
                buftype = {
                    nofile = { enabled = false },
                },
            },
        },
    },
}
