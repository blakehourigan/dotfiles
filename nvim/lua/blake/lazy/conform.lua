return {
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                python = { "black" },
            },
        },
        config = function(_, opts)
            -- Initialize conform with your options
            require("conform").setup(opts)

            -- Setup format on save
            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = "*.py",
                callback = function(args)
                    require("conform").format({ bufnr = args.buf })
                end,
            })
        end,
    }
}
