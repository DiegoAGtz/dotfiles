return {
    "nvim-tree/nvim-tree.lua",
    event = "BufEnter",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    opts = function()
        return {
            view = {
                centralize_selection = true,
                adaptive_size = false,
                side = "right",
                preserve_window_proportions = true
            }
        }
    end,
    config = function(_, opts)
        local nvim_tree = require("nvim-tree")
        nvim_tree.setup(opts)
    end,
}
