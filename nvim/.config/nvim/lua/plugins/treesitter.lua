return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        -- Associate Jenkinsfile with groovy
        vim.filetype.add({
            filename = {
                ["Jenkinsfile"] = "groovy",
            },
            pattern = {
                ["Jenkinsfile.*"] = "groovy",
            },
        })

        -- Setup Tree-sitter
        local config = require("nvim-treesitter.configs")
        config.setup({
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true },
            ensure_installed = {
                "markdown",
                "markdown_inline",
                "groovy",
            },
        })
    end
}

