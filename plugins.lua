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
        dependencies = {
            { "p00f/nvim-ts-rainbow" },
            { "andymass/vim-matchup" },
            { "nvim-treesitter/nvim-treesitter-textobjects" },
            { "JoosepAlviste/nvim-ts-context-commentstring" },
            {
                "nvim-treesitter/nvim-treesitter-context",
                config = function()
                    require("treesitter-context").setup()
                end,
            },
        },
    },
    {
        "abecodes/tabout.nvim",
        config = function(_, opts)
            require("tabout").setup {
                tabkey = "", -- key to trigger tabout, set to an empty string to disable
                backwards_tabkey = "", -- key to trigger backwards tabout, set to an empty string to disable
                act_as_tab = true, -- shift content if tab out is not possible
                act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
                enable_backwards = true,
                completion = true, -- if the tabkey is used in a completion pum
                tabouts = {
                    { open = "'", close = "'" },
                    { open = '"', close = '"' },
                    { open = "`", close = "`" },
                    { open = "(", close = ")" },
                    { open = "[", close = "]" },
                    { open = "{", close = "}" },
                },
                ignore_beginning = true, -- if the cursor is at the beginning of a filled element it will rather tab out than shift the content
                exclude = {}, -- tabout will ignore these filetypes
            }
        end,
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
        config = function()
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
            -- Fold options
            vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
            vim.o.foldcolumn = "1" -- '0' is not bad
            vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true
            vim.api.nvim_command "highlight AdCustomFold guifg=#6699CC"

            require("ufo").setup {
                fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
                    local newVirtText = {}
                    local suffix = ("  %d "):format(endLnum - lnum)
                    local sufWidth = vim.fn.strdisplaywidth(suffix)
                    local targetWidth = width - sufWidth
                    local curWidth = 0

                    for _, chunk in ipairs(virtText) do
                        local chunkText = chunk[1]
                        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                        if targetWidth > curWidth + chunkWidth then
                            table.insert(newVirtText, chunk)
                        else
                            chunkText = truncate(chunkText, targetWidth - curWidth)
                            local hlGroup = chunk[2]
                            table.insert(newVirtText, { chunkText, hlGroup })
                            chunkWidth = vim.fn.strdisplaywidth(chunkText)
                            -- str width returned from truncate() may less than 2nd argument, need padding
                            if curWidth + chunkWidth < targetWidth then
                                suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
                            end
                            break
                        end
                        curWidth = curWidth + chunkWidth
                    end

                    -- Second line
                    local lines = vim.api.nvim_buf_get_lines(0, lnum, lnum + 1, false)
                    local secondLine = nil
                    if #lines == 1 then
                        secondLine = lines[1]
                    elseif #lines > 1 then
                        secondLine = lines[2]
                    end
                    if secondLine ~= nil then
                        table.insert(newVirtText, { secondLine, "AdCustomFold" })
                    end

                    table.insert(newVirtText, { suffix, "MoreMsg" })

                    return newVirtText
                end,
            }
        end,
        keys = {
            {
                "zR",
                function()
                    require("ufo").openAllFolds()
                end,
            },
            {
                "zM",
                function()
                    require("ufo").closeAllFolds()
                end,
            },
            {
                "Z",
                function()
                    local winid = require("ufo").peekFoldedLinesUnderCursor()
                    if not winid then
                        vim.lsp.buf.hover()
                    end
                end,
            },
            {
                "zr",
                function()
                    require("ufo").openFoldsExceptKinds()
                end,
            },
            {
                "zm",
                function()
                    require("ufo").closeFoldsWith()
                end,
            },
        },
    },
    -- To make a plugin not be loaded
    -- {
    --   "NvChad/nvim-colorizer.lua",
    --   enabled = false
    -- },
}

return plugins
