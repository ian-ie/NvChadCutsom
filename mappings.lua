---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<leader>q"] = {":q<CR>", "quit"},
    ["<leader>h"] = { ":noh <CR>", "clear highlights" },
    ["<leader>gg"] = { "<cmd> LazyGit <CR>", "open Lazygit" },
    ["<leader>fp"] = { "<cmd> Telescope project <CR>", "find project" },
    ["<leader>cd"] = { ":cd %:h <CR>", "cd curfile dir" },
    -- leader b
    ["<leader>bo"] = { "<cmd> BufOnly <CR>", "close all buffer but this" },
    ["<leader>bn"] = { "<cmd> enew <CR>", "new buffer" },
    ["<leader>bf"] = { "<cmd> Telescope buffers <CR>", "find buffers" },
    ["<leader>bc"] = {
      function()
        require("nvchad_ui.tabufline").close_buffer()
      end,
      "close buffer",
    },

    ["<A-j>"] = { ":move +1 <CR>", "move down" },
    ["<A-k>"] = { ":move -2 <CR>", "move up" },
  },
  i = {
    ["<C-s>"] = { "<ESC> :w<CR>", "save and exit insert mode" },
    ["<A-j>"] = { "<ESC> :move +1 <CR>", "move down" },
    ["<A-k>"] = { "<ESC> :move -2 <CR>", "move up" },
  },
}

-- more keybinds!
M.nvimtree = {
  n = {
    -- toggle
    ["<C-n>"] = { "<cmd> NvimTreeToggle <CR>", "toggle nvimtree" },

    -- focus
    ["<leader>e"] = { "<cmd> NvimTreeToggle <CR>", "toggle nvimtree" },
  },
}

return M
