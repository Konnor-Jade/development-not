return {
    -- 消息和通知UI美化插件
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
        views = {
            cmdline_popup = {        -- 命令行弹出窗口配置
                position = {         -- 位置设置
                    row = "20%",     -- 距离顶部5行
                    col = "50%",     -- 水平居中
                },
                size = {             -- 尺寸设置
                    width = 60,      -- 宽度为60列
                    height = "auto", -- 高度自动调整
                },
            },
            popupmenu = {                                                                 -- 弹出菜单配置
                relative = "editor",                                                      -- 相对于编辑器定位
                position = {                                                              -- 位置设置
                    row = 8,                                                              -- 距离顶部8行
                    col = "50%",                                                          -- 水平居中
                },
                size = {                                                                  -- 尺寸设置
                    width = 60,                                                           -- 宽度为60列
                    height = 10,                                                          -- 高度为10行
                },
                border = {                                                                -- 边框设置
                    style = "rounded",                                                    -- 圆角边框样式
                    padding = { 0, 1 },                                                   -- 内边距：上下0，左右1
                },
                win_options = {                                                           -- 窗口选项
                    winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" }, -- 高亮设置
                },
            },
        },
        -- LSP相关配置
        -- lsp = {
        --     override = {
        --         ["vim.lsp.util.convert_input_to_markdown_lines"] = true, -- 将输入转换为markdown行
        --         ["vim.lsp.util.stylize_markdown"] = true, -- 美化markdown
        --         ["cmp.entry.get_documentation"] = true, -- 获取文档
        --     },
        -- },
        -- -- 消息路由配置
        -- routes = {
        --     {
        --         filter = {
        --             event = "msg_show",
        --             any = {
        --                 { find = "%d+L, %d+B" },    -- 过滤行数和字节数消息
        --                 { find = "; after #%d+" },  -- 过滤after消息
        --                 { find = "; before #%d+" }, -- 过滤before消息
        --             },
        --         },
        --         view = "cmdline_popup", -- 使用cmdline_popup视图显示
        --     },
        -- },
        -- -- 预设配置
        -- presets = {
        --     bottom_search = true,         -- 在底部显示搜索
        --     command_palette = true,       -- 启用命令面板
        --     long_message_to_split = true, -- 长消息自动分割
        -- },
    },
    dependencies = {
        -- 如果懒加载以下插件，请确保添加正确的 `module="..."` 条目
        "MunifTanjim/nui.nvim",
        -- 可选依赖:
        --   `nvim-notify` 仅在需要使用通知视图时需要
        --   如果不可用，将使用 `mini` 作为后备方案
        "rcarriga/nvim-notify",
    }
}
