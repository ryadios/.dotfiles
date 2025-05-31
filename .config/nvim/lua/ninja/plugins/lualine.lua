return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        lazy = false,
        config = function()
            local lualine = require("lualine")
            local colors = {
                bg = "#1e1e2e",
                fg = "#cdd6f4",
                yellow = "#f9e2af",
                cyan = "#89dceb",
                darkblue = "#89b4fa",
                green = "#a6e3a1",
                orange = "#fab387",
                violet = "#f5c2e7",
                magenta = "#cba6f7",
                blue = "#74c7ec",
                red = "#f38ba8",
            }

            local mode_color = {
                n = colors.darkblue,
                i = colors.green,
                v = colors.blue,
                [""] = colors.red,
                V = colors.red,
                c = colors.magenta,
                no = colors.red,
                s = colors.orange,
                S = colors.orange,
                [""] = colors.orange,
                ic = colors.yellow,
                R = colors.violet,
                Rv = colors.violet,
                cv = colors.red,
                ce = colors.red,
                r = colors.cyan,
                rm = colors.cyan,
                ["r?"] = colors.cyan,
                ["!"] = colors.red,
                t = colors.red,
            }

            local theme = {}
            for _, m in ipairs({ "normal", "insert", "visual", "replace", "command", "inactive" }) do
                theme[m] = vim.tbl_extend("force", {}, {
                    a = { bg = "None", gui = "bold" },
                    b = { bg = "None", gui = "bold" },
                    c = { bg = "None", gui = "bold" },
                    x = { bg = "None", gui = "bold" },
                    y = { bg = "None", gui = "bold" },
                    z = { bg = "None", gui = "bold" },
                })
            end

            local conditions = {
                hide_in_width = function()
                    return vim.fn.winwidth(0) > 80
                end,
                alpha = function()
                    if vim.bo.filetype ~= "alpha" then
                        return true
                    end
                end,
            }

            local function get_buffers()
                local bufs = vim.api.nvim_list_bufs()
                local bufNumb = 0
                local function buffer_is_valid(buf_id, buf_name)
                    return 1 == vim.fn.buflisted(buf_id) and buf_name ~= ""
                end
                for idx = 1, #bufs do
                    local buf_id = bufs[idx]
                    local buf_name = vim.api.nvim_buf_get_name(buf_id)
                    if buffer_is_valid(buf_id, buf_name) then
                        bufNumb = bufNumb + 1
                    end
                end

                if bufNumb == 1 then
                    return bufNumb .. " "
                else
                    return bufNumb .. " "
                end
            end

            local function mason_updates()
                local registry = require("mason-registry")
                registry.refresh()
                local installed_packages = registry.get_installed_package_names()

                local packages_outdated = 0

                for _, pkg in pairs(installed_packages) do
                    local p = registry.get_package(pkg)
                    local version = p.get_installed_version(p)
                    local latest = p.get_latest_version(p)

                    if version ~= latest then
                        packages_outdated = packages_outdated + 1
                    end
                end

                return packages_outdated
            end

            local mode = {
                "mode",
                separator = { left = "", right = "" },
                right_padding = 2,
                color = function()
                    return { fg = mode_color[vim.fn.mode()] }
                end,
            }

            local alpha = {
                function()
                    return "Alpha Dashboard"
                end,
                color = { fg = colors.magenta },
                cond = function()
                    if vim.bo.filetype == "alpha" then
                        return true
                    end
                end,
            }

            local branch = {
                "branch",
                icon = "󰘬",
                -- color = { fg = colors.violet },
                on_click = function()
                    vim.cmd("LazyGit")
                end,
            }

            local diagnostics = {
                "diagnostics",
                sources = { "nvim_diagnostic" },
                symbols = { error = " ", warn = " ", info = " " },
                diagnostics_color = {
                    color_error = { fg = colors.red },
                    color_warn = { fg = colors.yellow },
                    color_info = { fg = colors.cyan },
                },
                color = { bg = mode, gui = "bold" },
            }

            local diff = {
                "diff",
                symbols = { added = " ", modified = "󰝤 ", removed = " " },
                diff_color = {
                    added = { fg = colors.green, bg = "None" },
                    modified = { fg = colors.orange, bg = "None" },
                    removed = { fg = colors.red, bg = "None" },
                },
                cond = conditions.hide_in_width,
            }

            local fileformat = {
                "fileformat",
                fmt = string.upper,
                symbols = { unix = "" },
                -- color = { fg = colors.green },
                cond = conditions.alpha,
            }

            local lazy = {
                require("lazy.status").updates,
                cond = require("lazy.status").has_updates,
                color = { fg = colors.violet, bg = "None" },
                on_click = function()
                    vim.ui.select({ "Yes", "No" }, { prompt = "Update plugins?" }, function(choice)
                        if choice == "Yes" then
                            vim.cmd("Lazy sync")
                        else
                            vim.notify("Update cancelled", vim.log.levels.INFO, { title = "Lazy" })
                        end
                    end)
                end,
            }
            local mason = {
                mason_updates() .. "",
                color = { fg = colors.violet, bg = "None" },
                cond = function()
                    return mason_updates() > 0
                end,
                icon = "",
                on_click = function()
                    vim.cmd("Mason")
                end,
            }
            local buffers = {
                get_buffers,
                icon = nil,
                -- color = { fg = colors.darkblue, bg = "None" },
                on_click = function()
                    require("buffer_manager.ui").toggle_quick_menu()
                end,
            }

            local filetype = {
                "filetype",
                -- color = { fg = colors.darkblue, bg = "None" },
                icon_only = true,
                padding = { left = 1, right = 1 },
                cond = conditions.alpha,
            }
            local progress = {
                "progress",
                padding = { left = 1, right = 1 },
                -- color = { fg = colors.magenta, bg = "None" },
            }
            local location = {
                "location",
                separator = { left = "", right = "" },
                padding = { left = 1, right = 0 },
                color = function()
                    return { fg = mode_color[vim.fn.mode()] }
                end,
            }
            local sep = {
                "%=",
                color = { fg = colors.bg, bg = "None" },
            }

            lualine.setup({
                options = {
                    theme = theme,
                    component_separators = "",
                    section_separators = "",
                    -- globalstatus = true,
                    always_divide_middle = false,
                },
                sections = {
                    lualine_a = { mode },
                    lualine_b = { alpha, branch },
                    lualine_c = { diagnostics, sep },
                    lualine_x = { diff, lazy, mason },
                    lualine_y = { buffers, filetype, progress },
                    lualine_z = { location },
                },
                tabline = {},
                extensions = {},
            })
        end,
    },
}
