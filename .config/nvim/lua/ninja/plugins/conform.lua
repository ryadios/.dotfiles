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
            -- NOTE: Add your .clang-format file path to your shell (.bashrc/.zshrc)

            -- Example: export CLANG_FORMAT_PATH="$HOME/.clang-format"
            local clang_format_path = vim.fn.getenv("CLANG_FORMAT_PATH") or "/"

            require("conform").setup({
                formatters_by_ft = {
                    typescript = { "prettierd" },
                    javascript = { "prettierd" },
                    javascriptreact = { "prettierd" },
                    typescriptreact = { "prettierd" },
                    css = { "prettierd" },
                    html = { "prettierd" },
                    json = { "fixjson" },
                    jsonc = { "fixjson" },
                    yaml = { "prettierd" },
                    -- markdown = { "prettierd", },
                    lua = { "stylua" },
                    python = { "isort", "yapf" },
                    c = { "clang-format" },
                    cpp = { "clang-format" },
                    java = { "google-java-format" },
                    sh = { "beautysh" },
                },
                format_on_save = {
                    lsp_format = "fallback",
                    timeout_ms = 1000,
                },
                formatters = {
                    clang_format = { "--style=file:" .. clang_format_path },
                    prettier = {
                        require_cwd = true,
                        -- cwd = require("conform.util").root_file({
                        -- ".prettierrc",
                        -- ".prettierrc.json",
                        -- ".prettierrc.yml",
                        -- ".prettierrc.yaml",
                        -- ".prettierrc.json5",
                        -- ".prettierrc.js",
                        -- ".prettierrc.cjs",
                        -- ".prettierrc.mjs",
                        -- ".prettierrc.toml",
                        -- "prettier.config.js",
                        -- "prettier.config.cjs",
                        -- "prettier.config.mjs",
                        -- }),
                    },
                    ["google-java-format"] = {
                        args = { "--aosp", "-" }, -- AOSP style uses 4 spaces instead of 2
                    },
                },
            })
        end,
    },
}
