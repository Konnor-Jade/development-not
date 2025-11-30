return {
    {
        --  nvim-tree
        --  https://github.com/nvim-tree/nvim-tree.lua
        --  https://github.com/nvim-tree/nvim-tree.lua/wiki/Migrating-To-Nvim-Tree-v3
        -- 用途: 在侧边栏显示文件树
        "nvim-tree/nvim-tree.lua",
        version = "*",      -- 表示使用最新的版本
        event = "VimEnter", -- 进入 Vim 时加载
        -- lazy = false, -- 启动时加载
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        keys = {
            { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "打开文件树" },
        },
        opts = {
            -- on_attach = on_attach, -- 在文件树中添加快捷键
            update_focused_file = {
                enable = false,
                update_root = false,
            },
            git = {
                enable = true, -- 启用 git
                ignore = true, -- 忽略 git 文件
            },
            filters = {
                -- 隐藏点文件
                dotfiles = true,
                -- 隐藏 node_modules 文件夹
                -- custom = { "node_modules" },
            },
            view = {
                width = 34, -- 宽度
                -- or 'right'
                side = "left", -- 位置
                number = false, -- 行号
                relativenumber = false, -- 相对行号
                signcolumn = "yes", -- 显示符号列
            },
            actions = {
                open_file = {
                    resize_window = true,
                    quit_on_open = false,
                },
            },
            system_open = {
                -- NOTE: WSL need wsl-open
                -- npm install -g wsl-open
                -- https://github.com/4U6U57/wsl-open/
                cmd = "open",
            },
            renderer = {
                root_folder_label = false, -- 根文件夹标签
                indent_markers = {
                    enable = false, -- 启用缩进标记
                    icons = {
                        corner = "└ ",
                        edge = "│ ",
                        none = "  ",
                    },
                },
                icons = {
                    webdev_colors = true, -- 启用 webdev 颜色
                    git_placement = "after", -- 在 git 图标后面显示
                },
            },
        },
        config = function(_, opts)
            require("nvim-tree").setup(opts)
        end,
    }
}
