-- ╭─────────────────────────────────────────────────────────╮
-- │                        Lsp.nvim                         │
-- ╰─────────────────────────────────────────────────────────╯

return {
    {
        "neovim/nvim-lspconfig",
        name = "lspconfig",
        cmd = { "LspInfo", "LspInstall", "LspUninstall" },
        event = { "BufReadPost", "BufNewFile" },
        keys = function()
            require("ninja.mappings").lsp()
        end,
        dependencies = { "saghen/blink.cmp" },
        config = function()
            -- Capabilities
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

            capabilities = vim.tbl_deep_extend("force", capabilities, {
                workspace = {
                    didChangeWatchedFiles = {
                        relativePatternSupport = true,
                    },
                },
            })

            -- Hover border
            vim.lsp.handlers["textDocument/hover"] = function(err, result, ctx, config)
                config = config or {}
                config.border = vim.g.border_style
                return vim.lsp.handlers.hover(err, result, ctx, config)
            end

            local servers = {
                biome = {},
                lua_ls = {},
                html = {},
                cssls = {},
                tailwindcss = {},
            }

            for server, opts in pairs(servers) do
                vim.lsp.config(
                    server,
                    vim.tbl_deep_extend("force", {
                        capabilities = capabilities,
                    }, opts)
                )

                vim.lsp.enable(server)
            end
        end,
    },
    {
        "pmizio/typescript-tools.nvim",
        name = "typescript-tools",
        dependencies = { "neovim/nvim-lspconfig" },
        ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
        config = function()
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

            require("typescript-tools").setup({
                capabilities = capabilities,
                settings = {
                    separate_diagnostic_server = true,
                    publish_diagnostic_on = "insert_leave",
                    expose_as_code_action = { "fix_all", "add_missing_imports", "remove_unused", "remove_unused_imports", "organize_imports" },
                    tsserver_max_memory = "auto",
                    tsserver_file_preferences = {
                        includeInlayParameterNameHints = "all",
                        includeCompletionsForModuleExports = true,
                        quotePreference = "auto",
                    },
                    tsserver_format_options = {},
                },
            })
        end,
    },
}
