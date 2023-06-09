---@type MappingsTable
local M = {}

M.general = {
    n = {
        [":"] = { ":", "enter command mode", opts = { nowait = true } },

        ["<leader>v"] = { ":Nvdash <CR>", "back home" },
        ["<leader>q"] = { ":q<CR>", "quit" },
        ["<leader>h"] = { ":noh <CR>", "clear highlights" },
        ["<leader>H"] = { ":cd ~/.config/nvim/lua/ | edit custom/chadrc.lua <CR>", "modify config" },
        ["<leader>o"] = { "<cmd>SymbolsOutline<CR>", "outline" },
        ["<leader>gg"] = { "<cmd> LazyGit <CR>", "open Lazygit" },
        ["<leader>fp"] = { "<cmd> Telescope projects <CR>", "find project" },
        ["<leader>cd"] = { ":cd %:h <CR>", "cd curfile dir" },

        ["<leader>lo"] = { ":lua vim.diagnostic.config({ virtual_text = true})<CR>", "open virtual" },
        ["<leader>lc"] = { ":lua vim.diagnostic.config({ virtual_text = false})<CR>", "close virtual" },
        ["<leader>lf"] = {
            function()
                vim.lsp.buf.format { async = true }
            end,
            "lsp formatting",
        },

        -- leader b
        ["<leader>bo"] = { "<cmd> BufOnly <CR>:e<CR>", "close all buffer but this" },
        ["<leader>bn"] = { "<cmd> enew <CR>", "new buffer" },
        ["<leader>bf"] = { "<cmd> Telescope buffers <CR>", "find buffers" },
        ["<leader>bc"] = {
            function()
                require("nvchad_ui.tabufline").close_buffer()
            end,
            "close buffer",
        },

        -- leader t
        ["<leader>tt"] = { "<cmd>TroubleToggle<cr>", "trouble" },
        ["<leader>tw"] = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "workspace" },
        ["<leader>td"] = { "<cmd>TroubleToggle document_diagnostics<cr>", "document" },
        ["<leader>tq"] = { "<cmd>TroubleToggle quickfix<cr>", "quickfix" },
        ["<leader>tl"] = { "<cmd>TroubleToggle loclist<cr>", "loclist" },
        ["<leader>tr"] = { "<cmd>TroubleToggle lsp_references<cr>", "references" },

        -- leader r
        ["<leader>rf"] = { "<cmd>%SnipRun<cr>", "file" },
        ["<leader>rs"] = { "<Plug>SnipRun", "snip" },
        ["<leader>rc"] = { "<Plug>SnipClose", "close" },
        ["<leader>rr"] = { "<Plug>SnipReset", "reset" },
    },

    i = {
        ["<C-s>"] = { "<ESC> :w<CR>", "save and exit insert mode" },
    },
}

-- more keybinds!
M.nvimtree = {
    n = {
        -- focus
        ["<C-n>"] = { "<cmd> NvimTreeFocus <CR>", "toggle nvimtree" },

        -- toggle
        ["<leader>e"] = { "<cmd> NvimTreeToggle <CR>", "toggle nvimtree" },
    },
}

M.lspconfig = {
    n = {
        ["gl"] = {
            function()
                vim.diagnostic.open_float { border = "rounded" }
            end,
            "floating diagnostic",
        },
    },
}
return M
