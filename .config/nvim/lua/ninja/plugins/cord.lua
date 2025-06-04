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
            buttons = {
                {
                    label = "View Repository",
                    url = function(opts)
                        return opts.repo_url
                    end,
                },
            },
            advanced = {
                plugin = {
                    -- log_level = vim.log.levels.OFF,
                },
            },
        },
    },
}
