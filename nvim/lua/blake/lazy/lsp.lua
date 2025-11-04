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
            vim.lsp.config['omnisharp'] = {

                handlers = {
                    ["textDocument/definition"] = function(...)
                        return require("omnisharp_extended").handler(...)
                    end,
                },
                enable_roslyn_analyzers = true,
                organize_imports_on_format = true,
                enable_import_completion = true,
            }

            vim.lsp.config['luals'] = {
                -- Command and arguments to start the server.
                cmd = { 'lua_ls' },
                -- Filetypes to automatically attach to.
                filetypes = { 'lua' },
                -- Sets the "workspace" to the directory where any of these files is found.
                -- Files that share a root directory will reuse the LSP server connection.
                -- Nested lists indicate equal priority, see |vim.lsp.Config|.
                root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
                -- Specific settings to send to the server. The schema is server-defined.
                -- Example: https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json
                settings = {
                    Lua = {
                        runtime = {
                            version = 'LuaJIT',
                        }
                    }
                }
            }

            vim.lsp.config('rust_analyzer', {})
            vim.lsp.config('clangd', {})
            vim.lsp.config('clangd', {})
            vim.lsp.config('ruff', {})
            vim.lsp.config('pyright', {
                settings = {
                    pyright = {
                        disableOrganizeImports = true,
                    },
                },
            })

            vim.lsp.enable('luals')
            vim.lsp.enable('omnisharp')

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
