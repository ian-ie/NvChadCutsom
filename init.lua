-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
vim.api.nvim_command("autocmd InsertLeave,CursorMoved * normal! zz")

vim.opt.relativenumber = true

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

vim.diagnostic.config({ virtual_text = false })

if vim.fn.exists "g:neovide" then
    vim.opt.guifont = { "JetBrains Mono, 等距更纱黑体 SC:h11" }
    vim.g.neovide_transparency = 0.95
    vim.g.neovide_cursor_vfx_mode = "railgun"
end
