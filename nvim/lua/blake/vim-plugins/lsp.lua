vim.lsp.config('lua_ls', {
    settings = {
        Lua = {
            codeLens = { enable = true },
            diagnostics = {
                globals = { "vim" },
            }
        }
    }
})

-- config soured from https://github.com/neovim/nvim-lspconfig/tree/master/lsp
vim.lsp.config('rust_analyzer', {
    cmd = { 'rust_analyzer' },
    filetypes = { 'rust' },
})

-- config soured from https://github.com/neovim/nvim-lspconfig/tree/master/lsp
vim.lsp.config('clangd', {
    cmd = { 'clangd' },
    filetypes = { 'c', 'cpp' },
    root_markers = {
        '.clangd',
        '.clangd-tidy',
        '.clang-format',
        'compile_commands.json',
        'compile_flags.txt',
        'configure.ac',
        '.git'
    }
})

vim.lsp.config('ruff', {})
vim.lsp.config('pyright', {
    settings = {
        pyright = {
            disableOrganizeImports = true,
        },
    },
})

vim.lsp.config('lemminx', {
    filetypes = { "xml", "axaml" }
})

vim.lsp.config('yamlfix', {
    filetypes = { "yml", "yaml" },
})

vim.lsp.enable('rust_analyzer', {})
vim.lsp.enable('clangd')
vim.lsp.enable('lua_ls')
vim.lsp.enable('lemminx')
vim.lsp.enable('yamlfix')
vim.lsp.enable('lua-format')

-- sourced from 'h lsp-attach'
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('my.lsp', {}),
    callback = function(ev)
        local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))

        if client:supports_method('textDocument/definition') then
            vim.keymap.set("n", "grd", vim.lsp.buf.definition)
        end

        -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
        if client:supports_method('textDocument/completion') then
            -- Optional: trigger autocompletion on EVERY keypress. May be slow!
            -- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
            -- client.server_capabilities.completionProvider.triggerCharacters = chars

            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = false })
        end

        -- Auto-format ("lint") on save.
        -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
        if not client:supports_method('textDocument/willSaveWaitUntil')
            and client:supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
                group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
                buffer = ev.buf,
                callback = function()
                    vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 })
                end,
            })
        end
    end,
})
