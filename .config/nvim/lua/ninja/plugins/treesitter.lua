-- ╭─────────────────────────────────────────────────────────╮
-- │                     Treesitter.nvim                     │
-- ╰─────────────────────────────────────────────────────────╯

return {
    {
        "nvim-treesitter/nvim-treesitter",
        name = "treesitter",
        cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
        build = ":TSUpdate",
        event = {
            "BufReadPost",
            "BufNewFile",
        },
        config = function()
            vim.filetype.add({
                pattern = {
                    [".env.*"] = "sh",
                    [".*/waybar/config"] = "jsonc",
                    [".*/kitty/*.conf"] = "bash",
                    [".*/hypr/.*%.conf"] = "hyprlang",
                },
            })

            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "vimdoc",
                    "lua",
                    "toml",
                    "json",
                    "jsonc",
                    "html",
                    "css",
                    "javascript",
                    "typescript",
                    "tsx",
                    "markdown",
                    "python",
                    "cpp",
                    "java",
                    "dockerfile",
                    "bash",
                    "hyprlang",
                },
                ignore_install = {},
                sync_install = false,
                auto_install = true,
                modules = {},
                highlight = {
                    enable = true,
                    use_languagetree = true,
                },
                indent = { enable = true },
            })
        end,
    },
}
