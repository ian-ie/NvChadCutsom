local M = {}

M.treesitter = {
    ensure_installed = {
        "vim",
        "lua",
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "c",
        "markdown",
        "markdown_inline",
    },
    indent = {
        enable = true,
        -- disable = {
        --   "python"
        -- },
    },
    textobjects = {
        select = {
            enable = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
                ["id"] = "@conditional.inner",
                ["ad"] = "@conditional.outer",
            },
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                ["]["] = "@function.outer",
                ["]m"] = "@class.outer",
                ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
            },
            goto_next_end = {
                ["]]"] = "@function.outer",
                ["]M"] = "@class.outer",
            },
            goto_previous_start = {
                ["[["] = "@function.outer",
                ["[m"] = "@class.outer",
            },
            goto_previous_end = {
                ["[]"] = "@function.outer",
                ["[M"] = "@class.outer",
            },
            goto_next = {
                ["]d"] = "@conditional.outer",
            },
            goto_previous = {
                ["[d"] = "@conditional.outer",
            },
        },
    },
    rainbow = {
        enable = true,
        vim.api.nvim_set_hl(0, "TSRainbow1", { fg = "#EC7063" }),
        vim.api.nvim_set_hl(0, "TSRainbow2", { fg = "#00BCD4" }),
        vim.api.nvim_set_hl(0, "TSRainbow3", { fg = "#F9BF3B" }),
        vim.api.nvim_set_hl(0, "TSRainbow4", { fg = "#87D37C" }),
        vim.api.nvim_set_hl(0, "TSRainbow5", { fg = "#AF7AC5" }),
        vim.api.nvim_set_hl(0, "TSRainbow6", { fg = "#3498DB" }),
        vim.api.nvim_set_hl(0, "TSRainbow7", { fg = "#FF9800" }),
        hlgroups = {
            "TSRainbow1",
            "TSRainbow2",
            "TSRainbow3",
            "TSRainbow4",
            "TSRainbow5",
            "TSRainbow6",
            "TSRainbow7",
        }
        -- colors = {}, -- table of hex strings
        -- termcolors = {} -- table of colour name strings
    },
    matchup = { enable = true },
    context_commentstring = { enable = true, enable_autocmd = false },
}

M.mason = {
    ensure_installed = {
        -- lua stuff
        "lua-language-server",
        "stylua",

        -- web dev stuff
        "css-lsp",
        "html-lsp",
        "typescript-language-server",
        "deno",
        "prettier",

        -- c/cpp stuff
        "clangd",
        "clang-format",
    },
}

-- git support in nvimtree
M.nvimtree = {
    git = {
        enable = true,
    },

    renderer = {
        highlight_git = true,
        icons = {
            show = {
                git = true,
            },
        },
    },
}

return M
