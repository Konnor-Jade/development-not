return {
    -- 启动页
    -- 使用 dashboard-nvim 插件
    -- https://github.com/nvimdev/dashboard-nvim

    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    dependencies = { { 'nvim-tree/nvim-web-devicons' } },
    opts = {
        theme = 'hyper',
        hide = {
            statusline = false,
        },
        project = {
            enable = true,
        },
        config = {
            header = {
                '',
                '███████╗██╗   ██╗███╗   ██╗██████╗  █████╗ ██╗   ██╗',
                '██╔════╝██║   ██║████╗  ██║██╔══██╗██╔══██╗╚██╗ ██╔╝',
                '███████╗██║   ██║██╔██╗ ██║██║  ██║███████║ ╚████╔╝ ',
                '╚════██║██║   ██║██║╚██╗██║██║  ██║██╔══██║  ╚██╔╝  ',
                '███████║╚██████╔╝██║ ╚████║██████╔╝██║  ██║   ██║   ',
                '╚══════╝ ╚═════╝ ╚═╝  ╚═══╝╚═════╝ ╚═╝  ╚═╝   ╚═╝   ',
                '',
            },
            center = {
                {
                    icon = "  ",
                    desc = "Projects                            ",
                    action = "Telescope projects",
                },
                {
                    icon = "  ",
                    desc = "Recently files                      ",
                    action = "Telescope oldfiles",
                },
                {
                    icon = "  ",
                    desc = "Edit keybindings                    ",
                    action = "edit ~/.config/nvim/lua/configs/mappings.lua",
                },
                {
                    icon = "  ",
                    desc = "Edit Projects                       ",
                    action = "edit ~/.local/share/nvim/project_nvim/project_history  ",
                },
                {
                    icon = "  ",
                    desc = "Edit .zshrc                        ",
                    action = "edit ~/.zshrc",
                },
                -- {
                --   icon = "  ",
                --   desc = "Change colorscheme                  ",
                --   action = "ChangeColorScheme",
                -- },
                {
                    icon = "  ",
                    desc = "Edit init.lua                       ",
                    action = "edit ~/.config/nvim/init.lua",
                },
                {
                    icon = "  ",
                    desc = "Find file                           ",
                    action = "Telescope find_files",
                },
                {
                    icon = "  ",
                    desc = "Find text                           ",
                    action = "Telescope live_grep",
                },
            },
            footer = function()
                local stats = require("lazy").stats()
                local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
            end,
        },
    },
    config = function(_, opts)
        require('dashboard').setup(opts)
    end,
}
