-- ╭─────────────────────────────────────────────────────────╮
-- │                   Buffer-manager.nvim                   │
-- ╰─────────────────────────────────────────────────────────╯

return {
    {
        "j-morano/buffer_manager.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        lazy = false,
        keys = function()
            require("ninja.mappings").buffer()
        end,
        opts = {},
    },
}
