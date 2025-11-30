-- 安装 flash.nvim 插件
-- 用途: 快速跳转到指定位置
return {
    "folke/flash.nvim",
    -- 延迟加载
    event = "VeryLazy",
    opts = {},
    -- stylua: ignore
    keys = {
        -- 普通模式、可视模式和操作符模式下使用 s 触发快速跳转
        {
            "s",
            mode = { "n", "x", "o" },
            function()
                require("flash").jump()
            end,
            desc = "Flash",
        },
        -- 使用 S 触发基于 treesitter 的跳转
        {
            "S",
            mode = { "n", "x", "o" },
            function()
                require("flash").treesitter()
            end,
            desc = "Flash Treesitter",
        },
        -- 操作符模式下使用 r 触发远程跳转
        {
            "r",
            mode = "o",
            function()
                require("flash").remote()
            end,
            desc = "Remote Flash",
        },
        -- 操作符模式和可视模式下使用 R 触发基于 treesitter 的搜索
        {
            "R",
            mode = { "o", "x" },
            function()
                require("flash").treesitter_search()
            end,
            desc = "Treesitter Search",
        },
        -- 命令模式下使用 Ctrl+s 切换 flash 搜索
        {
            "<c-s>",
            mode = { "c" },
            function()
                require("flash").toggle()
            end,
            desc = "Toggle Flash Search",
        },
    },
}
