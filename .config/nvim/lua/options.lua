-- ╭─────────────────────────────────────────────────────────╮
-- │                       Vim Options                       │
-- ╰─────────────────────────────────────────────────────────╯

local opt = vim.opt
local g = vim.g
local opts = {}

opts.initial = function()
    opt.laststatus = 0 -- sets global status line
    opt.clipboard = "unnamedplus" -- sync system & neovim clipboard
    opt.termguicolors = true -- true terminal color support
    opt.list = true
    opt.listchars = { trail = "·", nbsp = "␣" } -- show non printable characters
    opt.fillchars:append({
        vert = "▏", -- vertical separator character
        horiz = "▁", -- horizontal separator character
        eob = " ", -- default ~
    })
    opt.shortmess:append("aIF") -- short message
    opt.cursorline = true -- highlight current line
    opt.cursorlineopt = "number" -- highlight current line number
    opt.ruler = true -- show line and column number
    opt.number = true -- show line number
    opt.relativenumber = false -- relative line number
    opt.breakindent = true -- show break indent
    opt.linebreak = true -- wrap long lines at characters in 'breakat'
    opt.swapfile = false -- disable swap file
    opt.undofile = true -- undo history across sessions
    opt.cmdheight = 0 -- hide command line

    g.border_style = "rounded" ---@type "single"|"double"|"rounded"
    g.winblend = 0 -- disable window transparency
    g.mapleader = " " -- sets leader key
    g.have_nerd_font = true -- enable nerd font

    g.loaded_perl_provider = 0
    g.loaded_ruby_provider = 0
end

opts.final = function()
    opt.completeopt = { "menuone", "noselect", "noinsert" } -- completion options
    opt.wildmenu = true -- enhanced cmdline completion menu
    opt.pumheight = 10 -- popup menu height
    opt.ignorecase = true -- case insensitive search
    opt.smartcase = true
    opt.timeout = false -- disable timeout
    opt.updatetime = 400 -- delay for triggering diagnostics
    opt.splitbelow = true
    opt.splitright = true
    opt.scrolloff = 2 -- minimum lines to keep above and below cursor
    opt.sidescrolloff = 2
    opt.inccommand = "split" -- show preview of substitution

    -- Indenting
    opt.shiftwidth = 4
    opt.smartindent = true
    opt.tabstop = 4
    opt.expandtab = true
    opt.softtabstop = 4

    -- Statusline
    local statusline_ascii = ""
    opt.statusline = "%#Normal#" .. statusline_ascii .. "%="
end

-- Disable shada until plugins are loaded
local shada = vim.o.shada
vim.o.shada = ""
vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
        vim.o.shada = shada
        pcall(vim.cmd.rshada, { bang = true })
    end,
})

vim.diagnostic.config({
    virtual_text = {
        prefix = "",
        suffix = "",
        format = function(diagnostic)
            return " " .. diagnostic.message .. " "
        end,
    },
    underline = {
        severity = { min = vim.diagnostic.severity.WARN },
    },
    signs = {
        text = {
            -- [vim.diagnostic.severity.HINT] = "",
            -- [vim.diagnostic.severity.ERROR] = "✘",
            -- [vim.diagnostic.severity.INFO] = "◉",
            -- [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.HINT] = "",
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.WARN] = "",
        },
    },
    update_in_insert = true,
})

return opts
