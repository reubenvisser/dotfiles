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
				ensure_installed = { "lua_ls", "ruff", "clangd", "bashls", "pyright", "ts_ls" },
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

			vim.lsp.config("lua_ls", {
				capabilities = capabilities,
				on_attach = on_attach,
			})
			vim.lsp.config("pyright", {
				capabilities = capabilities,
				on_attach = on_attach,
			})
			vim.lsp.config("ruff", {
				capabilities = capabilities,
                on_attach = function(client, bufnr)
                    -- Optional: let Pyright handle hover so they don’t fight
                    client.server_capabilities.hoverProvider = false
                    on_attach(client, bufnr)
                end,
			})
			vim.lsp.config("clangd", {
				capabilities = capabilities,
				on_attach = on_attach,
				filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
			})
			vim.lsp.config("bashls", {
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
            vim.lsp.config("ts_ls", {
                capabilities = capabilities,
                on_attach = on_attach(),
                settings = {
                    typescript = { preferences = { preferGoToSourceDefinition = true } },
                    javascript = { preferences = { preferGoToSourceDefinition = true } },
                },
            })
		end
	}
}
