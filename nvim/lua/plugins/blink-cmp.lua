return {
    -- 自动补全插件
    "saghen/blink.cmp",
    version = "*",                      -- 使用最新版本
    dependencies = {
        "rafamadriz/friendly-snippets", -- 代码片段依赖
    },
    event = "VeryLazy",                 -- 延迟加载
    opts = {
        completion = {
            documentation = {
                auto_show = true, -- 自动显示文档
            },
            trigger = {
                -- 当为 true 时，在进入插入模式时预加载补全项
                prefetch_on_insert = true,

                -- 当为 false 时，在代码片段中不会自动显示补全窗口
                show_in_snippet = true,

                -- 当为 true 时，在输入任何字母数字、`-` 或 `_` 后显示补全窗口
                show_on_keyword = true,

                -- 当为 true 时，在输入触发字符后显示补全窗口
                show_on_trigger_character = true,

                -- LSP 可以通过触发字符指示何时显示补全窗口
                -- 但是，某些 LSP（如 tsserver）返回的字符本质上会
                -- 始终显示窗口。我们默认阻止这些字符。
                show_on_blocked_trigger_characters = { ' ', '\n', '\t' },
                -- 你也可以通过函数按文件类型阻止：
                -- show_on_blocked_trigger_characters = function(ctx)
                --   if vim.bo.filetype == 'markdown' then return { ' ', '\n', '\t', '.', '/', '(', '[' } end
                --   return { ' ', '\n', '\t' }
                -- end,

                -- 当此选项和 show_on_trigger_character 都为 true 时，在
                -- 接受一个项目后，当光标位于触发字符之后时显示补全窗口
                show_on_accept_on_trigger_character = true,

                -- 当此选项和 show_on_trigger_character 都为 true 时，在
                -- 进入插入模式时，当光标位于触发字符之后时显示补全窗口
                show_on_insert_on_trigger_character = true,

                -- 触发字符列表（在 `show_on_blocked_trigger_characters` 之上），当
                -- 在进入插入模式/接受项目时，如果光标位于触发字符之后，
                -- 这些字符不会触发补全窗口
                show_on_x_blocked_trigger_characters = { "'", '"', '(' },
                -- 或者使用函数，类似于 show_on_blocked_trigger_character
            },
        },
        keymap = {
            preset = "super-tab",     -- 使用 super-tab 预设键位映射
        },
        sources = {
            default = { "path", "snippets", "buffer", "lsp" },     -- 默认补全来源
        },
        cmdline = {
            sources = function()
                local cmd_type = vim.fn.getcmdtype()
                if cmd_type == "/" or cmd_type == "?" then
                    return { "buffer" }     -- 搜索模式下使用缓冲区补全
                end
                if cmd_type == ":" then
                    return { "cmdline" }     -- 命令行模式下使用命令补全
                end
                return {}
            end,
            keymap = {
                preset = "super-tab",     -- 命令行模式下也使用 super-tab 预设
            },
            completion = {
                menu = {
                    auto_show = true,     -- 自动显示补全菜单
                },
            },
        }
    }
}
