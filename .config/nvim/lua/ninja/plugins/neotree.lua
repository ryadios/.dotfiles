-- ╭─────────────────────────────────────────────────────────╮
-- │                      Neotree.nvim                       │
-- ╰─────────────────────────────────────────────────────────╯

return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        enabled = true,
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        cmd = "Neotree",
        keys = {
            require("ninja.mappings").neotree(),
        },
        opts = {
            close_if_last_window = true,
            enable_git_status = true,
            sources = { "filesystem", "buffers", "document_symbols" },
            filesystem = {
                use_libuv_file_watcher = true,
                follow_current_file = { enabled = true },
                filtered_items = { visible = true },
            },
            window = {
                position = "right",
                width = 30,
            },
            default_component_configs = {
                indent = {
                    with_expanders = true,
                    expander_collapsed = "",
                    expander_expanded = "",
                    expander_highlight = "NeoTreeExpander",
                },
                modified = {
                    symbol = "",
                    highlight = "grey",
                },
            },
            hide_root_node = true,
            retain_hidden_root_indent = false,
        },
    },
}
