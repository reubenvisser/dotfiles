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
				ensure_installed = { "lua_ls", "pylsp" }
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
			lspconfig.pylsp.setup({
				capabilities = capabilities,
				on_attach = on_attach,

				settings = {
					pylsp = {
						plugins = {
							pycodestyle = { maxLineLength = 160 },
							rope_autoimport = { enable = true },
						}
					}
				}
			})
		end
	}
}
