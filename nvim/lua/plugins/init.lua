-- -@diagnostic disable: undefined-global

return {
    -- colorscheme 应该在启动 Neovim 时就可用
    {
        "folke/tokyonight.nvim",
        lazy = false,    -- 确保在启动时加载这个主题
        priority = 1000, -- 确保在所有其他启动插件之前加载
        opts = {
            -- style = "night",                   -- 主题样式
            -- transparent = false,               -- 透明背景
            styles = {
                comments = { italic = true },  -- 注释样式
                keywords = { italic = true },  -- 关键字样式
                functions = { italic = true }, -- 函数样式
                variables = { italic = true }, -- 变量样式
            },
        },
        config = function(_, opts)
            require("tokyonight").setup(opts)
            vim.cmd("colorscheme tokyonight")
        end,
    },
}
