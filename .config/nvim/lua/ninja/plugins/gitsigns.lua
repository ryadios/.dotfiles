-- ╭─────────────────────────────────────────────────────────╮
-- │                      Gitsigns.nvim                      │
-- ╰─────────────────────────────────────────────────────────╯

return {
    {
        "lewis6991/gitsigns.nvim",
        name = "gitsigns",
        event = { "BufReadPre", "BufNewFile" },
        keys = function()
            require("mappings").gitsigns()
        end,
        config = function()
            require("gitsigns").setup({
                signs = {
                    add = { text = "┃" },
                    change = { text = "┃" },
                    delete = { text = "_" },
                    topdelete = { text = "‾" },
                    changedelete = { text = "~" },
                    untracked = { text = "┆" },
                },
                signcolumn = true,
                signs_staged_enable = true,
                current_line_blame = false,
                current_line_blame_opts = {
                    virt_text_priority = 100,
                    use_focus = true,
                },
                preview_config = {
                    relative = "cursor",
                    row = 0,
                    col = 1,
                },
            })
        end,
    },
}
