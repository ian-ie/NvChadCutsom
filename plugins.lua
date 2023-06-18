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

            {
                "rmagatti/goto-preview",
                config = function()
                    require("goto-preview").setup {
                        default_mappings = true,
                        post_open_hook = function(_, win)
                            -- Close the current preview window with <Esc>
                            vim.keymap.set("n", "<Esc>", function()
                                vim.api.nvim_win_close(win, true)
                            end, { buffer = true })
                            vim.keymap.set("n", "q", function()
                                vim.api.nvim_win_close(win, true)
                            end, { buffer = true })
                        end,
                    }
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
            { "HiPhish/nvim-ts-rainbow2" } ,
            { "andymass/vim-matchup" },
            { "nvim-treesitter/nvim-treesitter-textobjects" },
            { "JoosepAlviste/nvim-ts-context-commentstring" },
        },
    },
    {
        "RRethy/nvim-treesitter-textsubjects",
        event = "VeryLazy",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require("nvim-treesitter.configs").setup {
                textsubjects = {
                    enable = true,
                    prev_selection = ",",
                    keymaps = {
                        ["."] = "textsubjects-smart",
                        [";"] = "textsubjects-container-outer",
                        ["i;"] = "textsubjects-container-inner",
                    },
                },
            }
        end,
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
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = { "rcarriga/nvim-notify", "MunifTanjim/nui.nvim" },
        opts = others.noice,
        keys = {
            { "<leader>ns", "<cmd>Notifications<cr>", desc = "show notifications" },
            { "<leader>nt", "<cmd>Noice telescope<cr>", desc = "show notice in telescope" },
            { "<leader>nm", "<cmd>messages<cr>", desc = "show message" },
            { "<leader>nd", "<cmd>NoiceDisable<cr>", desc = "NoiceDisable" },
            { "<leader>ne", "<cmd>NoiceEnable<cr>", desc = "NoiceEnable" },
        },
    },
    -- {
    --     "rcarriga/nvim-notify",
    --     lazy = true,
    --     event = "VeryLazy",
    --     config = function()
    --         local notify = require "notify"
    --         notify.setup(others.notify)
    --         vim.notify = notify
    --     end,
    -- },
    --
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
                T = { name = "translate" },
                l = { name = "lsp" },
                L = { name = "leetcode" },
                s = { name = "spectre" },
                n = { name = "noice" },
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
        cmd = "TranslateW",
        keys = {
            { "<leader>Tw", "<cmd>TranslateW<cr>", desc = "window", mode = { "n", "v" } },
            { "<leader>Tq", "<cmd>Translateq<cr>", desc = "cmdline", mode = { "n", "v" } },
            { "<leader>Te", "<cmd>Translate --target_lang=en <cr>", desc = "cmdline", mode = { "n", "v" } },
            { "<leader>Tr", "<cmd>TranslateR<cr>", desc = "replace", mode = { "n", "v" } },
            { "<leader>Tx", "<cmd>TranslateX<cr>", desc = "clipboard" },
            { "<leader>Th", "<cmd>TranslateH<cr>", desc = "history" },
            { "<leader>Tl", "<cmd>TranslateL<cr>", desc = "log" },
        },
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
        -- event = "VeryLazy",
        config = function ()
            require("leap").setup({
                require('leap').add_default_mappings()
            })
            -- code
        end
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
            { "<leader>Ld", "<cmd>LCToday<cr>", desc = "problem of day" },
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
    {
        "booperlv/nvim-gomove",
        event = "VeryLazy",
        config = function()
            require("gomove").setup {
                -- whether or not to map default key bindings, (true/false)
                map_defaults = true,
                -- whether or not to reindent lines moved vertically (true/false)
                reindent = true,
                -- whether or not to undojoin same direction moves (true/false)
                undojoin = true,
                -- whether to not to move past end column when moving blocks horizontally, (true/false)
                move_past_end_col = false,
            }
        end,
    },
    {
        "ethanholz/nvim-lastplace",
        event = "VeryLazy",
        config = function()
            require("nvim-lastplace").setup {
                lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
                lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
                lastplace_open_folds = true,
            }
        end,
    },
    {
        "windwp/nvim-spectre",
        cmd = { "Spectre" },
        config = function()
            require("spectre").setup()
        end,
        keys = {
            { "<leader>so", "<cmd>lua require('spectre').open()<cr>", desc = "find in workspace" },
            { "<leader>sf", "<cmd>lua require('spectre').open_file_search()<cr>", desc = "find in file" },
            { "<leader>sw", "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", desc = "find work in visual", mode = "v", },
            { "<leader>sv", "<cmd>lua require('spectre').open_visual()<cr>", desc = "find in visual", mode = "v" },
        },
    },
    {
        "mg979/vim-visual-multi",
        event = "VeryLazy",
        branch = "master",
        init = function()
            vim.g.VM_maps = {
                ["Find Under"]         = "<C-d>",
                ["Find Subword Under"] = "<C-d>" ,
                -- ["Select All"]         = "<C-a>" ,
                -- ["Select h"]           = "<C-h>",
                -- ["Select l"]           = "<C-l>",
                ["Add Cursor Up"]      = "<C-q>",
                ["Add Cursor Down"]    = "<C-e>",
                -- ["Add Cursor At Pos"]  = "<C-x>" ,
                -- ["Add Cursor At Word"] = "<C-w>" ,
                ["Remove Region"]      = "q"     ,
            }
        end
    },
    {
        "xiyaowong/transparent.nvim",
        lazy = false,
        config = function (_, opts)
            require("transparent").setup({
                vim.api.nvim_set_hl(0, 'NotifyBackground', vim.api.nvim_get_hl_by_name('Normal', true)),
                groups = { -- table: default groups
                    'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
                    'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
                    'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
                    'SignColumn', 'CursorLineNr', 'EndOfBuffer',
                },
                extra_groups = {
                    "NormalFloat", -- plugins which have float panel such as Lazy, Mason, LspInfo
                }, -- table: additional groups that should be cleared
                exclude_groups = {}, -- table: groups you don't want to clear
            })
        end
    }
    -- To make a plugin not be loaded
    -- {
    --   "NvChad/nvim-colorizer.lua",
    --   enabled = false
    -- },
}

return plugins
