local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {

    -- Override plugin definition options

    {
        "neovim/nvim-lspconfig",
        dependencies = {
            -- format & linting
            {
                "jose-elias-alvarez/null-ls.nvim",
                config = function()
                    require "custom.configs.null-ls"
                end,
            },
        },
        config = function()
            require "plugins.configs.lspconfig"
            require "custom.configs.lspconfig"
        end, -- Override to setup mason-lspconfig
    },

    -- override plugin configs
    {
        "williamboman/mason.nvim",
        opts = overrides.mason,
    },

    {
        "nvim-treesitter/nvim-treesitter",
        opts = overrides.treesitter,
    },

    {
        "nvim-tree/nvim-tree.lua",
        opts = overrides.nvimtree,
    },

    -- Install a plugin
    {
        "max397574/better-escape.nvim",
        event = "InsertEnter",
        config = function()
            require("better_escape").setup()
        end,
    },
    {
        "folke/which-key.nvim",
        config = function(_, opts)
            -- default config function's stuff
            dofile(vim.g.base46_cache .. "whichkey")
            require("which-key").setup(opts)
            -- your custom stuff
            require("which-key").register({
                f = { name = "file" },
                g = { name = "git" },
                b = { name = "buff" },
                r = { name = "sniprun" },
                j = { name = "jump" },
                t = { name = "trouble" },
                l = { name = "lsp" },
            }, { prefix = "<leader>" })
        end,
    },
    {
        "kdheepak/lazygit.nvim",
        cmd = "LazyGit",
    },
    {
        "nvim-telescope/telescope-project.nvim",
    },
    {
        "nvim-telescope/telescope.nvim",
        opts = {
            extensions_list = { "themes", "terms", "project" },
        },
    },
    {
        "numtostr/BufOnly.nvim",
        cmd = "BufOnly",
    },
    -- 翻译
    {
        "voldikss/vim-translator",
        lazy = false,
    },
    -- 代码片段运行
    {
        "michaelb/sniprun",
        build = "bash ./install.sh",
        cmd = "SnipRun",
    },
    -- 跳转
    {
        "ggandor/leap.nvim",
        event = "VeryLazy",
    },
    -- f 增强
    {
        "ggandor/flit.nvim",
        event = "VeryLazy",
        keys = { "f", "F", "t", "T" },
        dependencies = { "ggandor/leap.nvim" },
        config = function()
            require("flit").setup {
                keys = { f = "f", F = "F", t = "t", T = "T" },
                labeled_modes = "v",
                multiline = true,
                opts = {},
            }
        end,
    },
    -- 加("")
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup {
                -- Configuration here, or leave empty to use defaults
            }
        end,
    },
    -- 符号信息
    {
        "simrat39/symbols-outline.nvim",
        event = "InsertEnter",
        config = function()
            require("symbols-outline").setup {
                autofold_depth = 0,

                highlight_hovered_item = true,
                show_guides = true,
                auto_preview = false,
                position = "right",
                relative_width = true,
                width = 25,
                auto_close = false,
                show_numbers = false,
                show_relative_numbers = false,
                show_symbol_details = true,
                preview_bg_highlight = "Pmenu",
                auto_unfold_hover = true,
                fold_markers = { "", "" },
                wrap = false,
                keymaps = {
                    -- These keymaps can be a string or a table for multiple keys
                    close = { "<Esc>", "q" },
                    goto_location = "<Cr>",
                    focus_location = "o",
                    hover_symbol = "<C-space>",
                    toggle_preview = "K",
                    rename_symbol = "r",
                    code_actions = "a",
                    fold = "h",
                    unfold = "l",
                    fold_all = "P",
                    unfold_all = "U",
                    fold_reset = "Q",
                },
                lsp_blacklist = {},
                symbol_blacklist = {},
                symbols = {
                    File = { icon = "", hl = "@text.uri" },
                    Module = { icon = "", hl = "@namespace" },
                    Namespace = { icon = "", hl = "@namespace" },
                    Package = { icon = "", hl = "@namespace" },
                    Class = { icon = "𝓒", hl = "@type" },
                    Method = { icon = "ƒ", hl = "@method" },
                    Property = { icon = "", hl = "@method" },
                    Field = { icon = "", hl = "@field" },
                    Constructor = { icon = "", hl = "@constructor" },
                    Enum = { icon = "", hl = "@type" },
                    Interface = { icon = "ﰮ", hl = "@type" },
                    Function = { icon = "", hl = "@function" },
                    Variable = { icon = "", hl = "@constant" },
                    Constant = { icon = "", hl = "@constant" },
                    String = { icon = "𝓐", hl = "@string" },
                    Number = { icon = "#", hl = "@number" },
                    Boolean = { icon = "", hl = "@boolean" },
                    Array = { icon = "", hl = "@constant" },
                    Object = { icon = "", hl = "@type" },
                    Key = { icon = "🔐", hl = "@type" },
                    Null = { icon = "NULL", hl = "@type" },
                    EnumMember = { icon = "", hl = "@field" },
                    Struct = { icon = "𝓢", hl = "@type" },
                    Event = { icon = "🗲", hl = "@type" },
                    Operator = { icon = "+", hl = "@operator" },
                    TypeParameter = { icon = "𝙏", hl = "@parameter" },
                    Component = { icon = "󰡀", hl = "@function" },
                    Fragment = { icon = "", hl = "@constant" },
                },
            }
        end,
    },
    {
        "folke/trouble.nvim",
        cmd = { "TroubleToggle", "Trouble", "TroubleRefresh" },
        config = function()
            require("trouble").setup()
        end,
    },
    -- 置灰未使用变量
    {
        "zbirenbaum/neodim",
        event = "LspAttach",
        config = function()
            require("neodim").setup {
                alpha = 0.75,
                blend_color = "#000000",
                update_in_insert = {
                    enable = true,
                    delay = 100,
                },
                hide = {
                    virtual_text = true,
                    signs = false,
                    underline = false,
                },
            }
        end,
    },
    -- To make a plugin not be loaded
    -- {
    --   "NvChad/nvim-colorizer.lua",
    --   enabled = false
    -- },
}

return plugins
