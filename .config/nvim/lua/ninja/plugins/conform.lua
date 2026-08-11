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
                    typescript = { "biome-check" },
                    javascript = { "biome-check" },
                    javascriptreact = { "biome-check" },
                    typescriptreact = { "biome-check" },
                    css = { "biome-check" },
                    html = { "biome-check" },
                    json = { "biome-check" },
                    jsonc = { "biome-check" },
                    lua = { "stylua" },
                    sh = { "beautysh" },
                },
            })
        end,
    },
}
