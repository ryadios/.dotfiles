-- ╭─────────────────────────────────────────────────────────╮
-- │                        Mini.nvim                        │
-- ╰─────────────────────────────────────────────────────────╯

return {
    { -- Mini stuff
        "echasnovski/mini.nvim",
        name = "mini",
        keys = function()
            require("ninja.mappings").mini()
        end,
        event = function()
            if vim.fn.argc() == 0 then -- if no args were passed
                return "VimEnter"
            else
                return { "InsertEnter", "LspAttach" }
            end
        end,
        config = function()
            local configs = {
                pick = {
                    options = {
                        use_cache = true,
                    },
                    window = {
                        config = {
                            border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
                        },
                        prompt_prefix = "  ",
                    },
                },
                bufremove = {
                    silent = true,
                },
                extra = {},
                visits = {
                    store = {
                        path = vim.fn.stdpath("cache") .. "mini-visits-index",
                    },
                },
                git = {},
                ai = {}, -- TODO: Learn mini.ai
                surround = {}, -- TODO: Learn mini.surround
                pairs = {
                    mappings = {
                        -- ["<"] = {
                        --     action = "closeopen",
                        --     pair = "<>",
                        --     neigh_pattern = "[^\\].", -- ignore \>
                        --     register = { cr = false },
                        -- },
                    },
                },
                comment = {},
                move = {
                    mappings = {
                        left = "<S-h>",
                        right = "<S-l>",
                        down = "<S-j>",
                        up = "<S-k>",
                        line_left = "<S-h>",
                        line_right = "<S-l>",
                        line_down = "<S-j>",
                        line_up = "<S-k>",
                    },
                },
                -- starter = {
                --     evaluate_single = false,
                --     header = require("ninja.header").getHeader(3),
                --     footer = os.date("%B %d, %I:%M %p"),
                --     content_hooks = {
                --         require("mini.starter").gen_hook.aligning("center", "center"),
                --     },
                --     items = {
                --         {
                --             name = "   Bookmarked Files",
                --             action = "lua MiniExtra.pickers.visit_paths { filter = 'todo' }",
                --             section = " Actions ", -- Nerd Font terminal icon for Actions section
                --         },
                --         {
                --             name = "   Lazy Update",
                --             action = ":Lazy update",
                --             section = " Actions ",
                --         },
                --         {
                --             name = "   Open Blank File",
                --             action = ":enew",
                --             section = " Actions ",
                --         },
                --         {
                --             name = "   Find Files",
                --             action = "lua MiniPick.builtin.files()",
                --             section = " Actions ",
                --         },
                --         {
                --             name = "   Recent Files",
                --             action = "lua MiniExtra.pickers.oldfiles()",
                --             section = " Actions ",
                --         },
                --         {
                --             name = "   Quit",
                --             action = ":q!",
                --             section = " Actions ",
                --         },
                --     },
                -- },
            }

            for module, config in pairs(configs) do
                require("mini." .. module).setup(config)
            end
        end,
    },
}
