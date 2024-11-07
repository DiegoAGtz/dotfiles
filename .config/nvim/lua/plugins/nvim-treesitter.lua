return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function ()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = { "lua", "javascript", "go" },
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },
            autopairs = { enable = true },
            autotag = { enable = true },

        })
    end
}
