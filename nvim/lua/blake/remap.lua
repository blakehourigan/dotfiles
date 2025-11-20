vim.g.mapleader = " "

vim.keymap.set("n", "<leader>jk", vim.cmd.Ex)

vim.keymap.set("n", "<leader>/", vim.cmd.noh)

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", '"_dP')

vim.keymap.set("n", "<leader>xx", "<cmd>source %<CR>")
vim.keymap.set("n", "<leader>x", ":.lua<CR>")
vim.keymap.set("v", "<leader>x", ":lua<CR>")
--vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, { desc = 'Go to Implementation' })

local job_id = 0
vim.keymap.set("n", "<leader>st", function()
    vim.cmd.vnew()
    vim.cmd.term()
    vim.cmd.wincmd("J")
    vim.api.nvim_win_set_height(0, 10)
    job_id = vim.bo.channel
    local key = vim.api.nvim_replace_termcodes("<C-w>k", true, false, true)
    vim.api.nvim_feedkeys(key, 't', false)
end)

vim.keymap.set("n", "<leader>of", function()
    -- simple examble but could be
    -- go build or
    -- make
    vim.fn.chansend(job_id, ("firefox " .. vim.fn.expand('%:p') .. "\r\n"))
end)
vim.keymap.set("n", "<leader>d", function()
    vim.lsp.buf.definition()
end)
