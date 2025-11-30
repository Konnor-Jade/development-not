-- 安装 telescope
-- 用途: 模糊搜索文件、字符串、命令等
-- telescope 插件配置
-- 主要功能：模糊搜索文件、字符串、命令等
-- 依赖：
--   - plenary.nvim: 提供异步操作支持
--   - telescope-fzf-native.nvim: 提供更快的模糊搜索算法
--   - nvim-web-devicons: 提供文件图标支持
local telescope = {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && "
                .. "cmake --build build --config Release && "
                .. "cmake --install build --prefix build",
        },
    },
    -- 确保其他使用 telescope 的插件能正常工作
    cmd = "Telescope",
    opts = {
        defaults = {
            -- 默认使用插入模式
            initial_mode = "insert",
            -- 快捷键映射
            mappings = {
                i = {
                    ["<C-j>"] = "move_selection_next",     -- 向下移动选择
                    ["<C-k>"] = "move_selection_previous", -- 向上移动选择
                    ["<C-n>"] = "cycle_history_next",      -- 下一个历史记录
                    ["<C-p>"] = "cycle_history_prev",      -- 上一个历史记录
                    ["<C-c>"] = "close",                   -- 关闭
                    ["<C-u>"] = "preview_scrolling_up",    -- 预览窗口向上滚动
                    ["<C-d>"] = "preview_scrolling_down",  -- 预览窗口向下滚动
                },
            },
            -- 添加文件查找器配置
            find_files = {
                winblend = 20, -- 窗口透明度
            },
        },
        extensions = {
            fzf = {
                fuzzy = true,                   -- 启用模糊搜索
                override_generic_sorter = true, -- 覆盖通用排序器
                override_file_sorter = true,    -- 覆盖文件排序器
                case_mode = "smart_case",       -- 智能大小写匹配
            },
        },
    },
    -- 插件配置函数
    config = function(_, opts)
        local telescope = require "telescope"
        telescope.setup(opts)
        -- 确保在设置后加载扩展
        pcall(telescope.load_extension, "fzf")
    end,
    -- 快捷键设置
    keys = {
        { "<leader>ff", "<Cmd>Telescope find_files<CR>", desc = "查找文件", silent = true },
        { "<leader>fg", "<Cmd>Telescope live_grep<CR>", desc = "查找字符串", silent = true },
    },
}

return telescope
