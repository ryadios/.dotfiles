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

                local git = {
                    add = c.green,
                    change = c.yellow,
                    delete = c.red,
                    untracked = c.green,
                    ignored = c.fg_gutter,
                }

                hl.GitSignsAdd = { fg = git.add }
                hl.GitSignsChange = { fg = git.change }
                hl.GitSignsDelete = { fg = git.delete }

                hl.NeoTreeGitAdded = { fg = git.add }
                hl.NeoTreeGitStaged = { fg = git.add }
                hl.NeoTreeGitModified = { fg = git.change }
                hl.NeoTreeGitUnstaged = { fg = git.change }
                hl.NeoTreeGitDeleted = { fg = git.delete }
                hl.NeoTreeGitConflict = { fg = git.delete, bold = true }
                hl.NeoTreeGitUntracked = { fg = git.untracked }
                hl.NeoTreeGitRenamed = { fg = git.untracked }
                hl.NeoTreeGitIgnored = { fg = git.ignored }
                hl.NeoTreeModified = { fg = c.fg_gutter }
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
    {
        "navarasu/onedark.nvim",
        name = "onedark",
        priority = 999,
        lazy = false,
        opts = {
            style = "dark",
        },
        config = function(_, opts)
            require("onedark").setup(opts)
            vim.api.nvim_create_autocmd("ColorSchemePre", {
                pattern = "onedark",
                callback = function()
                    vim.o.background = "dark"
                end,
            })
        end,
    },
}
