return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            'saghen/blink.cmp',
            {
                "folke/lazydev.nvim",
                ft = "lua", -- only load on lua files
                opts = {
                    library = {
                        -- See the configuration section for more details
                        -- Load luvit types when the `vim.uv` word is found
                        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    },
                },
            },
        },
        config = function()
            local capabilities = require('blink.cmp').get_lsp_capabilities()

            require('lspconfig').csharp_ls.setup{
                cmd = { "csharp-ls" },
                filetypes = { "cs" },
                root_dir = require('lspconfig.util').root_pattern(".git", "*.sln", "*.csproj"),
                capabilities = capabilities,
            }

            --[==[
            vim.lsp.config('csharp_ls', {
                cmd = { "csharp-ls" },  -- or full path to the binary/script if not in $PATH
                filetypes = { "cs" },   -- C# files
                root_dir = require('lspconfig.util').root_pattern(".git", "*.sln", "*.csproj"),
                capabilities = capabilities,  -- pass your capabilities here if you have any
            })
            --]==]

            vim.lsp.config('lua_ls', { capabilities = capabilities })
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

            vim.api.nvim_create_autocmd('LspAttach', {
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if not client then return end

                    if client.name == 'ruff' then
                        --disable hover in favor of pyright
                        client.server_capabilities.hoverProvider = false
                        client.server_capabilities.definitionProvider = false
                    end

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
        end,
    }
}
