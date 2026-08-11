-- ╭─────────────────────────────────────────────────────────╮
-- │                     Treesitter.nvim                     │
-- ╰─────────────────────────────────────────────────────────╯

return {
    {
        "nvim-treesitter/nvim-treesitter",
        name = "treesitter",
        cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            vim.filetype.add({
                pattern = {
                    [".env.*"] = "sh",
                    [".*/waybar/config"] = "jsonc",
                    [".*/kitty/*.conf"] = "bash",
                    [".*/hypr/.*%.conf"] = "hyprlang",
                },
            })

            require("nvim-treesitter").setup({
                ensure_installed = {
                    "vimdoc",
                    "lua",
                    "toml",
                    "json",
                    "jsonc",
                    "html",
                    "css",
                    "scss",
                    "javascript",
                    "typescript",
                    "tsx",
                    "markdown",
                    "markdown_inline",
                    "yaml",
                    "dockerfile",
                    "bash",
                    "hyprlang",
                },
                ignore_install = {},
                sync_install = false,
                auto_install = false,
                highlight = {
                    enable = true,
                    use_languagetree = true,
                },
                indent = { enable = true },
            })
        end,
    },
}
