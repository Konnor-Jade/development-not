-- 显示光标所在行的上下文, 函数头
return {
    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy",
    opts = function()
        require('treesitter-context').setup {
            enable = true, -- 启用插件
            max_lines = 3, -- 显示的最大行数
            mode = "cursor", -- 上下文模式
        }
    end,
}
