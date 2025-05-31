-- ╭─────────────────────────────────────────────────────────╮
-- │                      Colorschemes                       │
-- ╰─────────────────────────────────────────────────────────╯

return {
    -- Colorschemes
    {
        "folke/tokyonight.nvim",
        name = "tokyonight",
        lazy = true,
        priority = 1000,
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
                -- Change variable color to yellow
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
    },
    {
        "bluz71/vim-nightfly-guicolors",
        priority = 1000,
        config = function()
            vim.g.nightflyItalics = true
            vim.g.nightflyCursorColor = true
            vim.g.nightflyNormalFloat = true
            vim.g.nightflyWinSeparator = 2
        end,
    },
    {
        "yorumicolors/yorumi.nvim",
    },
    {
        "neanias/everforest-nvim",
    },
    {
        "catppuccin/nvim",
        config = function()
            require("catppuccin").setup({
                flavour = "frappe", -- latte, frappe, macchiato, mocha
                background = {
                    -- :h background
                    light = "frappe",
                    dark = "mocha",
                },
                transparent_background = false, -- disables setting the background color.
                show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
                term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
                dim_inactive = {
                    enabled = false, -- dims the background color of inactive window
                    shade = "dark",
                    percentage = 0.15, -- percentage of the shade to apply to the inactive window
                },
                no_italic = false, -- Force no italic
                no_bold = false, -- Force no bold
                no_underline = false, -- Force no underline
                styles = {
                    -- Handles the styles of general hi groups (see `:h highlight-args`):
                    comments = { "italic" }, -- Change the style of comments
                    conditionals = { "italic" },
                    loops = {},
                    functions = {},
                    keywords = {},
                    strings = {},
                    variables = {},
                    numbers = {},
                    booleans = {},
                    properties = {},
                    types = {},
                    operators = {},
                    -- miscs = {}, -- Uncomment to turn off hard-coded styles
                },
                color_overrides = {},
                custom_highlights = {},
                default_integrations = true,
                integrations = {
                    cmp = true,
                    gitsigns = true,
                    neotree = false,
                    treesitter = true,
                    zenmode = false,
                    notify = false,
                    mini = {
                        enabled = true,
                        indentscope_color = "",
                    },
                    -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
                },
            })
        end,
    },
    {
        "rebelot/kanagawa.nvim",
    },
    {
        "ellisonleao/gruvbox.nvim",
    },
    {
        "bluz71/vim-moonfly-colors",
    },
    {
        "rmehri01/onenord.nvim",
    },
    {
        "Shatur/neovim-ayu",
    },
    {
        "craftzdog/solarized-osaka.nvim",
    },
    {
        "rose-pine/neovim",
    },
    {
        "projekt0n/github-nvim-theme",
    },
    {
        "diegoulloao/neofusion.nvim",
        priority = 1000,
        config = true,
        opts = ...,
    },
}
