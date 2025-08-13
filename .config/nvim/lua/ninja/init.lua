-- ╭─────────────────────────────────────────────────────────╮
-- │                        Lazy.nvim                        │
-- ╰─────────────────────────────────────────────────────────╯

local conf_path = vim.fn.stdpath("config") --[[@as string]]

local plugins = {

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
        "nvim-treesitter/nvim-treesitter-context",
        lazy = false,
    },

    {
        "windwp/nvim-ts-autotag",
        event = "InsertEnter",
        opts = {
            opts = {
                enable_close = true, -- Auto close tags
                enable_rename = true, -- Auto rename pairs of tags
                enable_close_on_slash = false, -- Auto close on trailing </
            },
        },
    },

    {
        "3rd/image.nvim",
        lazy = false,
        enabled = false,
        opts = {},
    },

    {
        "m4xshen/hardtime.nvim",
        lazy = false,
        dependencies = { "MunifTanjim/nui.nvim" },
        opts = {},
    },

    {
        "nvim-tree/nvim-web-devicons",
        config = function()
            require("nvim-web-devicons").setup({
                override_by_extension = {
                    ["css"] = {
                        icon = "󰌜",
                        color = "#306AF1",
                        name = "Css",
                    },
                },
            })
        end,
    },

    { import = "ninja.plugins" },

    {
        name = "options",
        event = "VeryLazy",
        dir = conf_path,
        config = function()
            require("ninja.options").final()
            require("ninja.mappings").general()
            require("ninja.mappings").misc()
        end,
    },
}

require("lazy").setup(plugins, {
    concurrency = 4, -- plugins to load concurrently
    defaults = {
        lazy = true,
    },
    install = {
        -- colorscheme = { "catppuccin" },
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
