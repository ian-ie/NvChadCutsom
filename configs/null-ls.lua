local present, null_ls = pcall(require, "null-ls")

if not present then
    return
end

local b = null_ls.builtins

local sources = {

    b.formatting.fixjson.with { extra_args = {"-i 4"}},

    b.formatting.prettier.with { filetypes = { "javascript", "typescript" }, extra_args = { "--tab-width=4" } },

    -- Lua
    b.formatting.stylua.with { extra_args = { "--indent-width", 4 } },

    -- python
    b.formatting.isort,
    b.formatting.black,
    b.diagnostics.flake8,

    -- go
    b.formatting.gofmt,
    b.formatting.goimports,

    -- rust
    b.formatting.rustfmt,
}

null_ls.setup {
    debug = true,
    sources = sources,
}
