vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.wrap = false
vim.opt.expandtab = true

-- maybe one day i'll find a better way to do this
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
  callback = function()
    vim.bo.tabstop = 2
    vim.bo.softtabstop = 2
    vim.bo.shiftwidth = 2
  end,
})

vim.g.mapleader = " "
-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>pv",  "<cmd>Oil<CR>")

vim.opt.autoread = true
vim.opt.clipboard = "unnamedplus"
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable spell checking
vim.opt.spell = true
vim.opt.spelllang = { 'en_au' }

-- Move line up or down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<leader>e", function() vim.diagnostic.open_float({ border = "rounded" }) end, { silent = true })
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Always centre after scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Jenkins file pickup
vim.filetype.add({
  pattern = {
    [".*Jenkinsfile.*"] = "groovy",
    [".*%.jenkinsfile"] = "groovy",
  },
})

-- Install packages
vim.pack.add({
    "https://github.com/ellisonleao/gruvbox.nvim",
    "https://github.com/stevearc/oil.nvim",
    "https://github.com/nvim-lua/plenary.nvim",
    { src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2" },
    "https://github.com/nvim-telescope/telescope.nvim",
    "https://github.com/tpope/vim-fugitive",
    "https://github.com/lewis6991/gitsigns.nvim",
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/mason-org/mason-lspconfig.nvim",
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/hrsh7th/nvim-cmp",
    "https://github.com/hrsh7th/cmp-nvim-lsp",
    "https://github.com/L3MON4D3/LuaSnip",
    "https://github.com/saadparwaiz1/cmp_luasnip",
    "https://github.com/obsidian-nvim/obsidian.nvim",
})

-- Theme
require("gruvbox").setup({
   contrast = "hard"
})
vim.o.background = "dark"
vim.cmd("colorscheme gruvbox")

-- File navigation
require("oil").setup({
    view_options = {
        show_hidden = true,
    },
    keymaps = {
        ["<C-p>"] = false,
        ["gp"] = "actions.preview",

    },
})

local harpoon = require("harpoon")
harpoon:setup({
    settings = {
        key = function()
            local branch = vim.fn.system("git branch --show-current"):gsub("\n", "")
            return vim.uv.cwd() .. "-" .. branch
        end,
    },
})
vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<C-b>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
vim.keymap.set("n", "<leader>h", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>j", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>k", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>l", function() harpoon:list():select(4) end)

require("telescope").setup({
    defaults = {
        path_display = { "truncate" },
    },
})
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>f', builtin.help_tags, {})
vim.keymap.set('n', '<leader>ps', builtin.live_grep, {})

-- Git stuff
require('gitsigns').setup({
    current_line_blame = true
})
vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", {})
vim.keymap.set("n", "<leader>gl", ":tab	Git log -10 -- %<CR>", {})

-- Syntax highlighting
vim.api.nvim_create_autocmd('FileType', {
    callback = function()
        local ft = vim.bo.filetype
        if ft == 'oil' or ft == 'harpoon' then return end
        local lang = vim.treesitter.language.get_lang(ft)
        if lang then
            if not pcall(vim.treesitter.language.inspect, lang) then
                require('nvim-treesitter').install({ lang })
            end
        end
        pcall(vim.treesitter.start)
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})

-- Obsidian
require("obsidian").setup({
    workspaces = {
        { name = "vault", path = "~/work/obsidian" },
    },
    note_id_func = function(title)
        local suffix = ""
        if title ~= nil then
            suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
        else
            for _ = 1, 4 do
                suffix = suffix .. string.char(math.random(65, 90))
            end
        end
        return suffix
    end,
    legacy_commands = false,
    ui = { enable = false },
})

-- LSP
require("mason").setup({ })
require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "ruff", "clangd", "bashls", "pyright", "ts_ls" },
    automatic_installation = true,
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
      local opts = { buffer = ev.buf }
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "gr", require('telescope.builtin').lsp_references, opts)
      vim.keymap.set("n", "K", function() vim.lsp.buf.hover({ border = "rounded" }) end, opts)
  end,
})

vim.lsp.config("lua_ls", { capabilities = capabilities })
vim.lsp.config("pyright", { capabilities = capabilities })
vim.lsp.config("ruff", {
    capabilities = capabilities,
    on_attach = function(client)
        client.server_capabilities.hoverProvider = false
        client.server_capabilities.definitionProvider = false
    end,
})
vim.lsp.config("clangd", {
    capabilities = capabilities,
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
})
vim.lsp.config("bashls", {
    capabilities = capabilities,
    settings = {
        bashIde = {
            indentation = { character = " ", size = 4 }
        }
    }
})
vim.lsp.config("ts_ls", {
    capabilities = capabilities,
    settings = {
        typescript = { preferences = { preferGoToSourceDefinition = true } },
        javascript = { preferences = { preferGoToSourceDefinition = true } },
    },
})

-- Completions
local cmp = require("cmp")
local luasnip = require("luasnip")

require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_lua").load({ paths = { "~/.config/nvim/snippets/" } })
luasnip.setup({ update_events = "TextChanged,TextChangedI" })

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    window = {
        completion = cmp.config.window.bordered({ border = "rounded" }),
        documentation = cmp.config.window.bordered({ border = "rounded" }),
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
    }, {
        { name = "buffer" },
    }),
})

