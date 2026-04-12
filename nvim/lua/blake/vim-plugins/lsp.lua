vim.lsp.config('lua_ls', { capabilities = capabilities })

vim.lsp.config('yamlfix', {
    capabilities = capabilities,
    filetypes = { "yml", "yaml" },
})

vim.lsp.config('rust_analyzer', {})
vim.lsp.config('clangd', {})
vim.lsp.config('ruff', {})
vim.lsp.config('pyright', {
    settings = {
        pyright = {
            disableOrganizeImports = true,
        },
    },
})
vim.lsp.config('lemminx', {
    filetypes = {"xml", "axaml"}
})

vim.lsp.enable('rust_analyzer', {})
vim.lsp.enable('lemminx')
vim.lsp.enable('clangd')

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        local bufnr = args.buf
        local builtin = require('telescope.builtin')

        if not client then return end

        if client.name == 'ruff' then
            --disable hover in favor of pyright
            client.server_capabilities.hoverProvider = false
            client.server_capabilities.definitionProvider = false
        end
        -- get Implementations 
        vim.keymap.set('n', '<leader>gi', builtin.lsp_implementations, { buffer = bufnr, desc = 'Go to Implementation' })
        -- get references
        vim.keymap.set('n', '<leader>gr', builtin.lsp_references, { buffer = bufnr, desc = 'Find References' })
        -- rename across the project
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = bufnr, desc = 'Rename Symbol' })

        vim.keymap.set("n", "<leader>d", vim.lsp.buf.definition)

        if client:supports_method('textDocument/formatting') then
            -- Format the current buffer on save
            vim.api.nvim_create_autocmd('BufWritePre', {
                buffer = args.buf,
                callback = function()
                    vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
                end,
            })
        end
    end,
})

