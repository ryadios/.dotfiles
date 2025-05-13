-- ╭─────────────────────────────────────────────────────────╮
-- │                        Lazy.nvim                        │
-- ╰─────────────────────────────────────────────────────────╯

local conf_path = vim.fn.stdpath("config") --[[@as string]]

local plugins = {

    -- Colorschemes
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = true,
        priority = 1000,
        enabled = false, -- Disable theme
        init = function()
            vim.cmd.colorscheme("catppuccin")
        end,
        opts = {
            transparent_background = true,
            compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
            compile = true,
            flavour = "mocha",
            integrations = {
                snacks = true,
                treesitter = true,
                mason = true,
                blink_cmp = true,
                native_lsp = {
                    enabled = true,
                    virtual_text = {
                        errors = { "italic" },
                        hints = { "italic" },
                        warnings = { "italic" },
                        information = { "italic" },
                    },
                    underlines = {
                        errors = { "undercurl" },
                        hints = { "undercurl" },
                        warnings = { "undercurl" },
                        information = { "undercurl" },
                    },
                },
                mini = {
                    enabled = true,
                },
            },
        },
    },

    {
        "folke/tokyonight.nvim",
        name = "tokyonight",
        lazy = true,
        priority = 1000,
        -- enabled = false, -- Disable theme
        init = function()
            vim.cmd.colorscheme("tokyonight-storm")
        end,
        opts = {
            style = "storm",
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
                hl["@variable"] = { fg = c.yellow }
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
            end,
        },
    },

    -- LuaLS setup
    {
        "folke/lazydev.nvim",
        name = "lazydev",
        ft = "lua",
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
            enabled = true,
        },
    },

    {
        "folke/which-key.nvim",
        name = "which-key",
        event = "VeryLazy",
        opts = {
            preset = "helix",
            icons = {
                separator = "│",
            },
        },
    },

    {
        "LudoPinelli/comment-box.nvim",
        name = "comment-box",
        lazy = false,
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        lazy = false,
        main = "ibl",
        opts = {
            indent = {
                char = "▏",
            },
            scope = {
                show_start = false,
                show_end = false,
                show_exact_scope = false,
            },
            exclude = {
                filetypes = {
                    "help",
                    "dashboard",
                    "NvimTree",
                },
            },
        },
    },

    {
        "nvim-treesitter/nvim-treesitter-context",
        lazy = false,
    },

    {
        "windwp/nvim-ts-autotag",
        event = "InsertEnter",
        opts = {},
    },

    -- {
    --     "barrett-ruth/import-cost.nvim",
    --     build = "sh install.sh npm",
    --     -- event = "LazyFile",
    --     lazy = false,
    --     config = function()
    --         require("import-cost").setup()
    --     end,
    -- },

    { import = "ninja.plugins" },

    {
        name = "options",
        event = "VeryLazy",
        dir = conf_path,
        config = function()
            require("options").final()
            require("mappings").general()
            require("mappings").misc()
        end,
    },
}

require("lazy").setup(plugins, {
    concurrency = 4, -- plugins to load concurrently
    defaults = {
        lazy = true,
    },
    install = {
        colorscheme = { "catppuccin" },
    },
    dev = {
        path = vim.env.NVIM_DEV,
    },
    performance = {
        cache = {
            enabled = true,
        },
        reset_packpath = true,
        rtp = {
            disabled_plugins = {
                "osc52",
                "parser",
                "gzip",
                "netrwPlugin",
                "health",
                "man",
                "matchit",
                "rplugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
                "shadafile",
                "spellfile",
                "editorconfig",
            },
        },
    },
    change_detection = {
        enabled = false,
        notify = false,
    },
    ui = {
        border = "rounded",
        title = " lazy.nvim 󰒲  ",
        size = { width = 0.9, height = 0.9 },
    },
})
