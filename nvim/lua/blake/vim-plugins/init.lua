-- grab me plugins

vim.pack.add({
    { src = "https://github.com/nvim-lua/plenary.nvim", version = 'master'},
    { src = "https://github.com/ThePrimeagen/harpoon", version = 'harpoon2'},
    -------------------------------------------------------------------
    { src = "https://github.com/nvzone/volt", version = 'main'}, 
    { src = "https://github.com/nvzone/typr", version = 'main'},
    -------------------------------------------------------------------
    { src = "https://github.com/nvim-telescope/telescope.nvim", version = 'master'}, 
    { src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim", version = 'main'},
    { src = "https://github.com/nvim-lua/plenary.nvim", version = 'master'},
    -------------------------------------------------------------------
    { src = "https://github.com/neogitorg/neogit", version = 'master'}, 
    { src = "https://github.com/nvim-lua/plenary.nvim", version = 'master'},
    { src = "https://github.com/sindrets/diffview.nvim", version = 'main'},
    -------------------------------------------------------------------
    { src = "https://github.com/mason-org/mason.nvim", version = 'main'}, 
    -------------------------------------------------------------------
    { src = "https://github.com/neovim/nvim-lspconfig", version = 'master' },
    -------------------------------------------------------------------
    { src = "https://github.com/seblyng/roslyn.nvim", version = 'main' }
})

-- add builtin packages to this session 
vim.cmd("packadd nvim.undotree")

-- setups 
require("harpoon").setup()

require("telescope").setup({
    pickers = {
        find_files = {
            theme = "ivy"
        }
    }
})

require("mason").setup(
    {

        registries = {
            "github:Crashdummyy/mason-registry", -- The Roslyn/C# registry
            "github:mason-org/mason-registry",   -- The default registry 
        },
    }
)

-- my config of the plugins
require("blake.vim-plugins.harpoon")
require("blake.vim-plugins.Typr")
require("blake.vim-plugins.undotree")
require("blake.vim-plugins.telescope")
require("blake.vim-plugins.neogit")
require("blake.vim-plugins.lsp")
