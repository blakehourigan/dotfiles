local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>en", function()
    builtin.find_files {
        cwd = vim.fn.stdpath("config")
    }
end
)
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})

vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		if vim.bo.buftype == 'nofile' then
			vim.opt.autocomplete = false
			return
		end
		vim.opt.autocomplete = true
	end,
})
