-- ╭─────────────────────────────────────────────────────────╮
-- │                        Cord.nvim                        │
-- ╰─────────────────────────────────────────────────────────╯

return {
    {
        "vyfor/cord.nvim",
        branch = "master",
        build = ":Cord update",
        event = "VeryLazy",
        opts = {
            advanced = {
                plugin = {
                    -- log_level = vim.log.levels.OFF,
                },
            },
        },
    },
}
