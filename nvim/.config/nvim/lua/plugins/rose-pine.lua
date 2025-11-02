return {
    -- {
    --     "rose-pine/neovim",
    --     name = "rose-pine",
    --     config = function()
    --         vim.cmd.colorscheme "rose-pine"
    --     end
    -- }
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000, -- load before all other plugins
        config = function()
            require("gruvbox").setup({
                contrast = "hard",          -- options: "hard", "soft", or empty string
                transparent_mode = false,   -- set to true if you want a transparent background
            })
            vim.o.background = "dark"     -- use the dark variant
            vim.cmd([[colorscheme gruvbox]])
        end,
    },
}
