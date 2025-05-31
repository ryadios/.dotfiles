-- ╭─────────────────────────────────────────────────────────╮
-- │                  Highlight-colors.nvim                  │
-- ╰─────────────────────────────────────────────────────────╯

return {
    "brenoprata10/nvim-highlight-colors",
    event = "VeryLazy",
    opts = {},
    keys = {
        require("ninja.mappings").map("n", "<leader>uc", function()
            require("nvim-highlight-colors").toggle()
        end, "Toggle Highlight Colors", "󰌁"),
    },
}
