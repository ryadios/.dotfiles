return {
    {
        "goolord/alpha-nvim",
        event = "VimEnter",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            local startify = require("alpha.themes.startify")
            startify.file_icons.provider = "devicons"

            startify.opts.layout = {
                { type = "padding", val = 0 },
                startify.section.header,
                { type = "padding", val = 2 },
                startify.section.top_buttons,
                startify.section.mru_cwd,
                startify.section.mru,
                { type = "padding", val = 1 },
                startify.section.bottom_buttons,
                { type = "padding", val = 2 },
                startify.section.footer,
            }

            startify.section.header.opts.hl = "Function"

            startify.section.top_buttons.val = {
                startify.button("f", "  " .. "Find Files", ":Pick files <CR>"),
                startify.button("t", "  " .. "Change Theme", ":Themery <CR>"),
                startify.button("m", "  " .. "Mason", ":Mason <CR>"),
                startify.button("l", "󰚰  " .. "LazyUI", ":Lazy <CR>"),
            }

            for _, button in ipairs(startify.section.top_buttons.val) do
                button.opts.hl = "AlphaButtons"
                button.opts.hl_shortcut = "AlphaShortcut"
            end

            startify.section.mru.val = { { type = "padding", val = 0 } }

            startify.section.bottom_buttons.val = {
                startify.button("q", "Quit", "<cmd>q <CR>"),
            }

            for _, button in ipairs(startify.section.bottom_buttons.val) do
                button.opts.hl_shortcut = "AlphaShortcut"
            end

            startify.section.footer.val = {
                {
                    type = "text",
                    val = {
                        -- "",
                        "❝ It’s an important memory for me.",
                        "I’ll never forget it. Of course,",
                        "this time I spend talking to you is very important as well. ❞",
                        "",
                    },
                    opts = { hl = "AlphaFooter" },
                },
                {
                    type = "text",
                    val = "— Vladilena Milizé",
                    opts = { hl = "AlphaAuthor" },
                },
            }

            vim.api.nvim_set_hl(0, "AlphaAuthor", { fg = "#7aa2f7", italic = true })
            vim.api.nvim_set_hl(0, "AlphaFooter", { fg = "", italic = true })

            require("alpha").setup(startify.config)
        end,
    },
}
