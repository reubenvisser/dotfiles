return {
    "stevearc/oil.nvim",
    opts = {
        keymaps = {
            ["<C-p>"] = false,
            ["gp"] = "actions.preview",
        },
        view_options = {
            show_hidden = true,
        }
    },
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- optional
}
