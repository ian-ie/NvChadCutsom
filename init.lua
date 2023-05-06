-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

vim.wo.relativenumber = true
if vim.fn.exists "g:neovide" then
  -- vim.opt.guifont = { "JeBrains Mono", ":h1}
  vim.g.neovide_transparency = 0.95
  vim.g.neovide_cursor_vfx_mode = "ripple"
end
