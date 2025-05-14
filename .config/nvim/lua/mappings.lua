-- ╭─────────────────────────────────────────────────────────╮
-- │                    Mappings/Keybinds                    │
-- ╰─────────────────────────────────────────────────────────╯

local modules = require("modules")
local wk = require("which-key")

local icons = {
    setting = "",
    lock = "",
    search = "",
    git = "",
    lsp = "󰂓",
    diag = "",
    magic = "",
    tree = "",
    success = "",
    failure = "",
    view = "󰈈",
}

local function map(mode, keys, action, desc, icon)
    desc = desc or ""
    local opts = { noremap = true, silent = true, desc = desc }
    vim.keymap.set(mode, keys, action, opts)

    if icon then
        wk.add({
            { keys, icon = icon },
        })
    end
end

local M = {}
M.map = map

M.general = function()
    -- Insert movement
    map("i", "<C-h>", "<Left>")
    map("i", "<C-j>", "<Down>")
    map("i", "<C-k>", "<Up>")
    map("i", "<C-l>", "<Right>")

    -- Copy and paste in the same cursor position
    map("n", "p", function()
        local row, col = unpack(vim.api.nvim_win_get_cursor(0))
        vim.cmd("put")
        vim.api.nvim_win_set_cursor(0, { row + 1, col })
    end)

    -- Insert escape
    map("i", "jj", "<esc>")
    map("i", "<C-c>", "<esc>")

    -- Save only on new changes
    map("n", "<C-a>", "<cmd>update<CR>")

    -- Switching splits
    map("n", "<C-h>", "<C-w>h")
    map("n", "<C-j>", "<C-w>j")
    map("n", "<C-k>", "<C-w>k")
    map("n", "<C-l>", "<C-w>l")

    -- Buffer navigation
    map("n", "<Tab>", "<cmd>bnext<CR>")
    map("n", "<s-Tab>", "<cmd>bprev<CR>")

    -- Resize splits
    map("n", "<A-k>", ":resize +2<CR>")
    map("n", "<A-j>", ":resize -2<CR>")
    map("n", "<A-h>", ":vertical resize +2<CR>")
    map("n", "<A-l>", ":vertical resize -2<CR>")

    -- Center cursor on scroll
    map("n", "<C-d>", "<C-d>zz")
    map("n", "<C-u>", "<C-u>zz")

    -- Search and help mappings
    map("v", "??", 'y:h <C-R>"<cr>"') -- Show vim help
    map("v", "?/", 'y:/ <C-R>"<cr>"') -- Search across the buffer
end

M.misc = function()
    map("n", "<leader>tm", function()
        modules.toggle_mode()
    end, "[T]oggle [Mode]", icons.setting)

    -- map("n", "<leader>tf", function()
    --     modules.toggle_flow()
    -- end, "[T]oggle [F]low", icons.lock)
end

M.oil = function()
    map("n", "-", "<cmd>Oil<CR>", "Project View (Netrw)")
end

M.mini = function()
    local minipick = require("mini.pick")
    local miniextra = require("mini.extra")
    local minivisits = require("mini.visits")
    local builtin = minipick.builtin
    local pickers = miniextra.pickers

    map({ "n" }, "<leader>ff", function()
        builtin.files()
    end, "[F]ind [Files]", icons.search)

    map({ "n" }, "<leader>fh", function()
        builtin.help()
    end, "[F]ind [H]elp", icons.search)

    map({ "n" }, "<leader>fk", function()
        pickers.keymaps()
    end, "[F]ind [K]eymaps", icons.search)

    map({ "n" }, "<leader>fg", function()
        builtin.grep_live()
    end, "[F]ind [G]rep", icons.search)

    map({ "n" }, "<leader>fr", function()
        builtin.resume()
    end, "[F]ind [R]esume", icons.search)

    map("n", "<leader>dp", function()
        pickers.diagnostic()
    end, "[D]iagnostics in [Picker]", icons.search)

    map("n", "<leader>gh", function()
        pickers.git_hunks()
    end, "[F]ind Git [H]unks", icons.git)

    map("n", "<leader>gc", function()
        pickers.git_commits()
    end, "[F]ind Git [C]ommits", icons.git)

    map("n", "<A-s>", function()
        miniextra.pickers.visit_paths({ filter = "todo" })
    end, "View TodoList", icons.view)

    map("n", "<A-a>", function()
        minivisits.add_label("todo")
    end, "Add File to TodoList", icons.success)

    map("n", "<A-A>", function()
        minivisits.remove_label("todo")
    end, "Remove File from TodoList", icons.failure)
end

M.gitsigns = function()
    -- TODO: Add gitsigns mappings
end

M.lsp = function()
    local minipick = require("mini.pick")
    vim.ui.select = minipick.ui_select

    -- Diagnostic mappings
    map("n", "dp", function()
        vim.diagnostic.jump({ count = -1, float = false })
    end, "[D]iagnostic [P]revious", icons.diag)

    map("n", "dn", function()
        vim.diagnostic.jump({ count = 1, float = false })
    end, "[D]iagnostic [N]ext", icons.diag)

    map("n", "<leader>df", function()
        vim.diagnostic.open_float({ border = vim.g.border_style })
    end, "Open [D]iagnostics [F]loat", icons.diag)

    map("n", "<leader>hi", function()
        modules.toggle_inlay_hint() -- toggle inlay hint
    end, "Toggle [I]nlay [H]int", "")

    map("n", "<leader>k", function()
        vim.lsp.buf.hover({ border = vim.g.border_style })
    end, "LSP Hover", icons.lsp)

    -- Lsp mappings
    map("n", "<leader>ld", vim.lsp.buf.definition, "Goto [L]SP [D]efinition", icons.lsp)
    map("n", "<leader>lh", vim.lsp.buf.declaration, "Goto [L]SP [D]eclaration", icons.lsp)
    map("n", "<leader>li", vim.lsp.buf.implementation, "Goto [L]SP [I]mplementation", icons.lsp)
    map("n", "<leader>lt", vim.lsp.buf.type_definition, "Goto [L]SP [T]ype Definition", icons.lsp)
    map("n", "<leader>lr", vim.lsp.buf.references, "Goto [L]SP [R]eference", icons.lsp)
    map({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, "[L]SP Code [A]ction", icons.lsp)
    map("n", "<leader>lc", vim.lsp.buf.rename, "[L]SP [R]ename", icons.lsp)
    map({ "i", "x" }, "<A-s>", vim.lsp.buf.signature_help, "LSP [S]ignature Help", icons.lsp)
end

M.conform = function()
    map({ "n", "v" }, "<leader>mp", function()
        require("conform").format({
            lsp_format = "fallback",
            timeout_ms = 1000,
        })
    end, "[M]ake [P]retty", icons.magic)
end

M.neotree = function()
    -- `show` flag -> no focus
    map("n", "<leader>ee", "<cmd>Neotree toggle show<CR>", "Neotree Toggle", icons.tree)
    map("n", "<leader>eg", "<cmd>Neotree git_status show<CR>", "Neotree Git Status", icons.tree)
    map("n", "<leader>eb", "<cmd>Neotree buffers<CR> show", "Neotree Buffers", icons.tree)
end

return M
