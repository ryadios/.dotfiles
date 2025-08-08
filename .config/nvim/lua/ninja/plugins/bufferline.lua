-- ╭─────────────────────────────────────────────────────╮
-- │                   Bufferline.nvim                   │
-- ╰─────────────────────────────────────────────────────╯

return {
    {
        "akinsho/bufferline.nvim",
        lazy = false,
        version = "*",
        dependencies = "nvim-tree/nvim-web-devicons",
        config = function()
            local bufferline = require("bufferline")

            bufferline.setup({
                highlights = {
                    -- fill = { bg = "NONE" },
                    fill = {
                        bg = "NONE",
                        fg = "NONE",
                    },
                    background = { bg = "NONE" },
                    tab = { bg = "NONE" },
                    tab_selected = { bg = "NONE" },
                    tab_separator = { bg = "NONE" },
                    tab_separator_selected = { bg = "NONE" },
                },
                options = {
                    indicator_icon = " ",
                    separator_style = { "", "" },
                    tab_size = 0,
                    buffer_close_icon = "",
                    modified_icon = "",
                    close_icon = "",
                    style_preset = bufferline.style_preset.minimal,
                    always_show_bufferline = false,
                    custom_filter = function(_, buf_numbers)
                        return #buf_numbers >= 2
                    end,
                },
            })
        end,
    },
}
