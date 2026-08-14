-- ╭─────────────────────────────────────────────────────────╮
-- │                     Treesitter.nvim                     │
-- ╰─────────────────────────────────────────────────────────╯

return {
    {
        "nvim-treesitter/nvim-treesitter",
        name = "treesitter",
        lazy = false,
        cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
        build = ":TSUpdate",
        config = function()
            local parsers = {
                "vimdoc",
                "lua",
                "toml",
                "json",
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
            }

            vim.filetype.add({
                pattern = {
                    [".env.*"] = "sh",
                    [".*/waybar/config"] = "jsonc",
                    [".*/kitty/*.conf"] = "bash",
                    [".*/hypr/.*%.conf"] = "hyprlang",
                },
            })

            require("nvim-treesitter").setup({})
            require("nvim-treesitter").install(parsers)

            vim.api.nvim_create_autocmd("FileType", {
                pattern = {
                    "bash",
                    "css",
                    "dockerfile",
                    "html",
                    "hyprlang",
                    "javascript",
                    "javascriptreact",
                    "json",
                    "jsonc",
                    "lua",
                    "markdown",
                    "scss",
                    "sh",
                    "toml",
                    "typescript",
                    "typescriptreact",
                    "yaml",
                },
                callback = function(args)
                    vim.treesitter.start(args.buf)
                    vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end,
            })
        end,
    },
}
