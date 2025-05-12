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
                    "ts_ls",
                    "html",
                    "cssls",
                    "tailwindcss",
                    "emmet_ls",
                    "lua_ls",
                    "pyright",
                    "clangd",
                    "jdtls",
                },
                automatic_installation = true,
            })
        end,
    },
}
