return {
	'nvim-lualine/lualine.nvim',
	requires = { 'kyazdani42/nvim-web-devicons' },
	config = function()
		require('lualine').setup({
			options = {
				theme = 'dracula'
			},
			sections = {
				lualine_c = {
					{
						'filename',
						file_status = true, -- displays file status (readonly status, modified status)
						path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
					}
				}
			}
		})
	end
}

