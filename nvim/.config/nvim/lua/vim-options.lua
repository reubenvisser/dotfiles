vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set nowrap")
vim.cmd("set expandtab")

vim.g.mapleader = " "
-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>pv",  "<cmd>Oil<CR>")

vim.opt.autoread = true
vim.opt.clipboard = "unnamedplus"
vim.opt.number = true
vim.opt.relativenumber = true

-- For obsidian plugin
vim.opt.conceallevel = 2

-- Enable spell checking
vim.opt.spell = true
vim.opt.spelllang = { 'en_us' }

-- Move line up or down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.api.nvim_set_keymap("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", { noremap = true, silent = true })
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Always centre after scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Jenkins file pickup
vim.filetype.add({
  pattern = {
    ["Jenkinsfile.*"] = "groovy",
    [".*%.jenkinsfile"] = "groovy",
  },
})
