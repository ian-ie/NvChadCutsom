local present, null_ls = pcall(require, "null-ls")

if not present then
    return
end

local b = null_ls.builtins

local sources = {

    -- webdev stuff
    b.formatting.deno_fmt.with { extra_args = { "--indent-width", 4 } }, -- choosed deno for ts/js files cuz its very fast!

    -- Lua
    b.formatting.stylua.with { extra_args = { "--indent-width", 4 } },

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
