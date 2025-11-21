return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.9",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' }
    },

    config = function()
        require("telescope").setup({
            pickers = {
                find_files = {
                    theme = "ivy"
                }
            }
        })

        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
        vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
        vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
        vim.keymap.set("n", "<leader>en", function()
            builtin.find_files {
                cwd = vim.fn.stdpath("config")
            }
        end)
    end,
}
