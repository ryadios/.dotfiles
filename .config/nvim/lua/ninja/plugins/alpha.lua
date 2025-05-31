return {
    {
        "goolord/alpha-nvim",
        event = "VimEnter",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            local startify = require("alpha.themes.startify")
            startify.file_icons.provider = "devicons"

            startify.section.top_buttons.val = {
                startify.button("f", " " .. "Find files", ":Pick files <CR>"),
                startify.button("p", " " .. "Select project", ":lua ProjectPicker() <CR>"),
                startify.button("t", " " .. "Change theme", ":Themery <CR>"),
                startify.button("m", " " .. "Mason", ":Mason <CR>"),
                startify.button("l", "󰚰 " .. "LazyUI", ":Lazy <CR>"),
            }

            for _, button in ipairs(startify.section.top_buttons.val) do
                button.opts.hl = "AlphaButtons"
                button.opts.hl_shortcut = "AlphaShortcut"
            end
            startify.section.header.opts.hl = "Function"

            for _, button in ipairs(startify.section.bottom_buttons.val) do
                button.opts.hl_shortcut = "AlphaShortcut"
            end

            startify.opts.layout[1].val = 4

            startify.section.mru_cwd.val[4].val = function()
                return {
                    startify.mru(4, vim.fn.getcwd()),
                }
            end

            require("alpha").setup(startify.config)
        end,
    },
}
