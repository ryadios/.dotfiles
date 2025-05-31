-- ╭─────────────────────────────────────────────────────────╮
-- │                       Snacks.nvim                       │
-- ╰─────────────────────────────────────────────────────────╯

return {
    {
        "folke/snacks.nvim",
        -- name = "snacks",
        lazy = false,
        priority = 1000,
        keys = {
            require("ninja.mappings").map({ "n" }, "<leader>o", function()
                require("snacks").scratch()
            end, "[O]pen Scratch Pad", ""),

            require("ninja.mappings").map({ "n" }, "<leader>un", function()
                require("snacks").notifier.hide()
            end, "Hide Notification", "󰵅"),

            require("ninja.mappings").map({ "n" }, "<Leader>uh", function()
                require("snacks").notifier.show_history()
            end, "Show Notification History", "󰵅"),
        },
        event = { "BufReadPost" },
        opts = {
            -- words = {
            --     enabled = true,
            --     debounce = 500,
            -- },
            notifier = {
                wo = {
                    winblend = vim.g.winblend,
                },
            },
            -- indent = {
            --     enabled = true,
            -- }
            -- dashboard = { -- TODO: Customize Dashboard
            --     enabled = true,
            --     preset = {
            --         header = require("ninja.header").getHeader(3),
            --     },
            --     sections = {
            --         { section = "keys", gap = 1, padding = 1 },
            --         { section = "startup" },
            --     },
            -- },
            -- statuscolumn = { enabled = true },
        },
    },
}
