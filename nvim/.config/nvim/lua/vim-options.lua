vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set nowrap")
vim.cmd("set expandtab")

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.opt.clipboard = "unnamedplus"
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable spell checking
vim.opt.spell = true
vim.opt.spelllang = { 'en_us' }

-- Move line up or down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Navigate vim panes better
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")

vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true })
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Auto load changes
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})

-- Always centre after scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Format selected lines to a specific line length
vim.api.nvim_create_user_command("FormatWidth", function(opts)
  local width = tonumber(opts.args) or 80
  -- Try using external fmt first
  local has_fmt = vim.fn.executable("fmt") == 1
  if has_fmt then
    vim.cmd(string.format("'<,'>!fmt -w %d", width))
  else
    -- Fallback to Vim's built-in formatter
    local old_tw = vim.bo.textwidth
    vim.bo.textwidth = width
    vim.cmd("'<,'>gq")
    vim.bo.textwidth = old_tw
  end
end, {
  range = true,
  nargs = 1,
  desc = "Format selected lines to given width (e.g., :'<,'>FormatWidth 72)",
})

-- Jenkins file pickup
vim.filetype.add({
  pattern = {
    ["Jenkinsfile.*"] = "groovy",
    [".*%.jenkinsfile"] = "groovy",
  },
})
