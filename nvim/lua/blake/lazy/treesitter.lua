return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",

    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = { "python", "vimdoc", "c", "lua", "rust", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
            sync_install = false,
            auto_install = false,
            highlight = {
                enable = true,

                disable = { "latex" },
                additional_vim_regex_highlighting = false,
            },
        })
    end,
}
