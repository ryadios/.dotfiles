-- ╭─────────────────────────────────────────────────────────╮
-- │                      Conform.nvim                       │
-- ╰─────────────────────────────────────────────────────────╯

return {
    {
        "stevearc/conform.nvim",
        name = "conform",
        event = { "BufReadPre", "BufNewFile" },
        keys = {
            require("ninja.mappings").conform(),
        },
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    typescript = { "biome" },
                    javascript = { "biome" },
                    javascriptreact = { "biome" },
                    typescriptreact = { "biome" },
                    css = { "biome" },
                    html = { "biome" },
                    json = { "biome" },
                    jsonc = { "biome" },
                    lua = { "stylua" },
                    sh = { "beautysh" },
                },
            })
        end,
    },
}
