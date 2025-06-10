return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "pyright", "ruff", "clangd", "bashls" },
			automatic_installation = true,

			})
		end
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local on_attach = function()
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
				vim.keymap.set("n", "gr", require('telescope.builtin').lsp_references, {})
				vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			end

			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
			lspconfig.pyright.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					pyright = {
						-- Using Ruff's import organizer
						disableOrganizeImports = true,
					},
					python = {
						analysis = {
							-- Ignore all files for analysis to exclusively use Ruff for linting
							ignore = { '*' },
						},
					},
				},
			})
			lspconfig.ruff.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
			lspconfig.clangd.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
			})
			lspconfig.bashls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					bashIde = {
						indentation = {
							character = " ", -- Use spaces
							size = 4         -- Set to 4 spaces
						}
					}
				}
			})
		end
	}
}
