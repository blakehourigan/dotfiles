return{
    {
        "mason-org/mason.nvim",
        opts = {
            registries = {
                "github:Crashdummyy/mason-registry", -- The custom registry for Roslyn/C#
                "github:mason-org/mason-registry",    -- The default official registry (always keep this one!)
            },

        }
    }
}
