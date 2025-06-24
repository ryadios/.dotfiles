-- ╭─────────────────────────────────────────────────────────╮
-- │                        Oil.nvim                         │
-- ╰─────────────────────────────────────────────────────────╯

return {
    {
        "stevearc/oil.nvim",
        name = "oil",
        cmd = "Oil",
        lazy = false,
        keys = function()
            require("ninja.mappings").oil()
        end,
        dependencies = { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
        config = function()
            require("oil").setup({
                default_file_explorer = true,
                delete_to_trash = true,
                skip_confirm_for_simple_edits = true,
                view_options = {
                    show_hidden = true,
                    natural_order = true,
                    is_always_hidden = function(name, _)
                        -- return name == ".." or name == ".git"
                        return name == ".."
                    end,
                },
                float = {
                    padding = 2,
                    max_width = 90,
                    max_height = 0,
                },
                win_options = {
                    wrap = true,
                    winblend = 0,
                },
                keymaps = {
                    ["<C-c>"] = false,
                    ["q"] = "actions.close",
                },
            })
        end,
    },
}
