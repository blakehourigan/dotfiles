vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

--vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
--vim.opt.undofile = true

vim.opt.wrap = true

vim.opt.termguicolors = true

vim.opt.clipboard = "unnamed,unnamedplus"

vim.opt.scrolloff = 8
--vim.opt.colorcolumn = "95"

vim.opt.updatetime = 50


vim.api.nvim_create_autocmd('TextYankPost', {
    desc = "Highlight when yanking text",
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end

})

vim.api.nvim_create_autocmd('TermOpen', {
    group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
    callback = function()
        vim.opt.nu = false
        vim.opt.relativenumber = true
    end
})
