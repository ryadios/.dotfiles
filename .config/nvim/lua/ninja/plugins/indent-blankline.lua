-- ╭─────────────────────────────────────────────────────────╮
-- │                  Indent-blankline.nvim                  │
-- ╰─────────────────────────────────────────────────────────╯

return {
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            vim.api.nvim_set_hl(0, "IblScope", { fg = "#61AFEF" })
            require("ibl").setup({
                indent = {
                    char = "│",
                    tab_char = "│",
                    smart_indent_cap = true,
                },
                scope = {
                    enabled = true,
                    show_start = false,
                    show_end = false,
                    show_exact_scope = true,
                },
                exclude = {
                    filetypes = {
                        "help",
                        "alpha",
                        "dashboard",
                        "neo-tree",
                        "Trouble",
                        "trouble",
                        "lazy",
                        "mason",
                        "notify",
                        "toggleterm",
                        "lazyterm",
                        "oil",
                    },
                    buftypes = {
                        "terminal",
                        "nofile",
                        "quickfix",
                        "prompt",
                    },
                },
            })
        end,
    },
}
