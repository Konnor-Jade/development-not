-- 安装 lspsaga
-- 代码导航
return {
    "nvimdev/lspsaga.nvim",
    cmd = "Lspsaga",
    opts = {
        finder = {
            keys = {
                toggle_or_open = "<CR>", -- 使用按键打开或关闭
            },
        },
    },
    keys = {
        { "<leader>lr", ":Lspsaga rename<CR>", desc = "重命名变量" },
        { "<leader>lc", ":Lspsaga code_action<CR>", desc = "代码操作" },
        { "<leader>ld", ":Lspsaga definition<CR>", desc = "跳转到定义" },
        { "<leader>lh", ":Lspsaga hover_doc<CR>", desc = "显示文档" },
        { "<leader>lR", ":Lspsaga finder<CR>", desc = "查找引用" },
        { "<leader>ln", ":Lspsaga diagnostic_jump_next<CR>", desc = "下一个诊断" },
        { "<leader>lp", ":Lspsaga diagnostic_jump_prev<CR>", desc = "上一个诊断" },

    }
}
