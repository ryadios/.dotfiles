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

            local on_attach = function(_, bufnr)
                -- TODO: Register keybinds
            end

            local servers = {
                lua_ls = {},
                html = {},
                cssls = {},
                ts_ls = {},
                tailwindcss = {},
                emmet_ls = {
                    filetypes = {
                        "html",
                        "typescriptreact",
                        "javascriptreact",
                        "css",
                        "sass",
                        "scss",
                        "less",
                        "svelte",
                    },
                },
                pyright = {},
                clangd = {},
                jdtls = {},
            }

            -- NEW API
            for server, opts in pairs(servers) do
                vim.lsp.config(
                    server,
                    vim.tbl_deep_extend("force", {
                        on_attach = on_attach,
                        capabilities = capabilities,
                    }, opts)
                )

                vim.lsp.enable(server)
            end
        end,
    },
}
