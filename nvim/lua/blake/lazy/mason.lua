<<<<<<< HEAD
return {
    {
        "mason-org/mason.nvim",
        opts = {}
    },
=======
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
>>>>>>> 2609a5f018421ae5bddffd28d47f6daf69e6b620
}
