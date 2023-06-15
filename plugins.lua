local overrides = require "custom.configs.overrides"
local others = require "custom.configs.others"

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
        dependencies = {
            { "p00f/nvim-ts-rainbow" },
            { "andymass/vim-matchup" },
            { "nvim-treesitter/nvim-treesitter-textobjects" },
            { "JoosepAlviste/nvim-ts-context-commentstring" },
        },
    },
    {
        "abecodes/tabout.nvim",
        opts = others.tabout,
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
                L = { name = "leetcode" },
            }, { prefix = "<leader>" })
        end,
    },
    {
        "kdheepak/lazygit.nvim",
        cmd = "LazyGit",
    },
    {
        "ahmedkhalf/project.nvim",
        config = function(_, opts)
            require("project_nvim").setup {
                manual_mode = false,
                detection_methods = { "lsp", "pattern" },
                patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
                ignore_lsp = { "null-ls", "copilot" },
                exclude_dirs = {},
                show_hidden = false,
                silent_chdir = true,
                scope_chdir = "global",
                datapath = vim.fn.stdpath "data",
            }
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        opts = {
            extensions_list = { "themes", "terms", "projects" },
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
        opts = others.flit,
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
        opts = others.symbols_outline,
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
    {
        "spin6lock/vim_sproto",
        ft = "sproto",
    },
    { "folke/neodev.nvim" },
    {
        "ian-ie/LeetCode.nvim",
        dir = "/mnt/d/work/LeetCode.nvim/",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            require("leetcode").setup {}
        end,
        keys = {
            { "<leader>Lg", "<cmd>LCLogin<cr>", desc = "login leetcode" },
            { "<leader>Ll", "<cmd>LCList<cr>", desc = "problem list" },
            { "<leader>Li", "<cmd>LCInfo<cr>", desc = "problem info" },
            { "<leader>Ld", "<cmd>LCDay<cr>", desc = "problem of day" },
            { "<leader>Lr", "<cmd>LCReset<cr>", desc = "rest code template" },
            { "<leader>Lt", "<cmd>LCTest<cr>", desc = "test" },
            { "<leader>Ls", "<cmd>LCSubmit<cr>", desc = "submit" },
        },
    },
    {
        "kevinhwang91/nvim-ufo",
        event = "BufRead",
        dependencies = {
            { "kevinhwang91/promise-async" },
            {
                "luukvbaal/statuscol.nvim",
                config = function()
                    local builtin = require "statuscol.builtin"
                    require("statuscol").setup {
                        -- foldfunc = "builtin",
                        -- setopt = true,
                        relculright = true,
                        segments = {
                            { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
                            { text = { "%s" }, click = "v:lua.ScSa" },
                            { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
                        },
                    }
                end,
            },
        },

        config = function()
            vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
            vim.o.foldcolumn = "1" -- '0' is not bad
            vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true
            vim.api.nvim_command "highlight AdCustomFold guifg=#6699CC"
            require("ufo").setup(others.ufo)
        end,
        keys = {
            { "zR", function() require("ufo").openAllFolds() end, desc = "open all folds", },
            { "zM", function() require("ufo").closeAllFolds() end, desc = "colse all folds", },
            { "Z", function() local winid = require("ufo").peekFoldedLinesUnderCursor() if not winid then vim.lsp.buf.hover() end end, desc = "preview fold", },
            { "zr", function() require("ufo").openFoldsExceptKinds() end, desc = "open same level fold", },
            { "zm", function() require("ufo").closeFoldsWith() end, desc = "close same level fold", },
        },
    },
    -- To make a plugin not be loaded
    -- {
    --   "NvChad/nvim-colorizer.lua",
    --   enabled = false
    -- },
}

return plugins
