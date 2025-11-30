return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        presets = {
            -- operators = false,
            -- motions = false,
            -- text_objects = false,
            -- windows = false,
            -- nav = false,
        },
    },
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Keymaps (which-key)",
        },
    },
}
