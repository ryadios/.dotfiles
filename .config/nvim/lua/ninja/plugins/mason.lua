-- ╭─────────────────────────────────────────────────────────╮
-- │                       Mason.nvim                        │
-- ╰─────────────────────────────────────────────────────────╯

return {
    {
        "williamboman/mason.nvim",
        lazy = false,
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            local mason = require("mason")
            local mason_lspconfig = require("mason-lspconfig")

            mason.setup({
                ui = {
                    border = "rounded",
                    title = " mason.nvim   ",
                    size = { width = 0.9, height = 0.9 },
                    icons = {
                        package_installed = "",
                        package_pending = "",
                        package_uninstalled = "",
                    },
                },
            })

            mason_lspconfig.setup({
                ensure_installed = {
                    "lua_ls",
                    "html",
                    "cssls",
                    "ts_ls",
                    "tailwindcss",
                    "emmet_ls",
                    "pyright",
                    "clangd",
                    "jdtls",
                },
                automatic_installation = true,
                automatic_enable = false,
            })
        end,
    },
}
