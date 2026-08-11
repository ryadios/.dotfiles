-- ╭─────────────────────────────────────────────────────────╮
-- │                      Colorschemes                       │
-- ╰─────────────────────────────────────────────────────────╯

return {
    {
        "folke/tokyonight.nvim",
        name = "tokyonight",
        priority = 1000,
        lazy = false,
        opts = {
            style = "night",
            transparent = true,
            styles = {
                comments = { italic = true },
                keywords = { italic = true },
                functions = {},
                variables = {},
                sidebars = "transparent",
                floats = "transparent",
            },
            on_highlights = function(hl, c)
                hl["@variable"] = { fg = c.red }
                hl["@lsp.type.variable"] = { link = "@variable" }
                hl["@variable.parameter"] = { fg = c.fg }
            end,
            on_colors = function(c)
                local util = require("tokyonight.util")
                local function darkenColors(colTable)
                    for k, v in pairs(colTable) do
                        if type(v) == "string" and v:sub(1, 1) == "#" then
                            colTable[k] = util.blend_bg(v, 0.90)
                        end
                    end
                end
                darkenColors(c)
                c.bg_statusline = "NONE"
            end,
        },
        config = function(_, opts)
            require("tokyonight").setup(opts)
            vim.cmd.colorscheme("tokyonight")
        end,
    },
}
