-- ╭─────────────────────────────────────────────────────────╮
-- │                   Todo-comments.nvim                    │
-- ╰─────────────────────────────────────────────────────────╯

return {
    { -- Highlight todo, notes, etc in comments
        "folke/todo-comments.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local todo_comments = require("todo-comments")

            vim.keymap.set("n", "]t", function()
                todo_comments.jump_next()
            end, { desc = "Next todo comment" })

            vim.keymap.set("n", "[t", function()
                todo_comments.jump_next()
            end, { desc = "Previous todo comment" })

            todo_comments.setup({
                signs = false,
            })

            -- TODO: Make todo comments picker + keybind

            -- TODO\: what else?
            -- HACK\: hmm.. this looks funky
            -- BUG\: this need fixing
            -- PERF\: full optimised
            -- NOTE\: adding a note
            -- WARNING\: this may get heated
        end,
    },
}
