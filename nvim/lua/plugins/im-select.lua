return {
    "keaising/im-select.nvim",
    config = function()
        require('im_select').setup({
            -- 在 `normal` 模式下输入法将被设置为 `default_im_select`
            -- Windows/WSL 默认值: "1033", 即英语美式键盘
            -- macOS 默认值: "com.apple.keylayout.ABC", 即美式键盘
            -- Linux 默认值:
            --          Fcitx5 使用 "keyboard-us"
            --          Fcitx 使用 "1"
            --          ibus 使用 "xkb:us::eng"
            -- 你可以使用 `im-select` 或 `fcitx5-remote -n` 来获取输入法名称
            default_im_select       = "com.apple.keylayout.ABC",

            -- 可以是二进制文件名、完整路径或表格，例如 'im-select'、
            -- '/usr/local/bin/im-select' 用于不需要额外参数的二进制文件，
            -- 或 { "AIMSwitcher.exe", "--imm" } 用于需要额外参数的二进制文件
            -- Windows/WSL 默认值: "im-select.exe"
            -- macOS 默认值: "macism"
            -- Linux 默认值: "fcitx5-remote" 或 "fcitx-remote" 或 "ibus"
            default_command         = "macism",

            -- 当触发以下事件时恢复默认输入法状态
            set_default_events      = { "VimEnter", "FocusGained", "InsertLeave", "CmdlineLeave" },

            -- 当触发以下事件时恢复之前使用的输入法状态
            -- 如果你不想在插入模式下恢复之前的输入法，
            -- 例如废弃的 `disable_auto_restore = 1`，只需将其设置为空
            -- 如 `set_previous_events = {}`
            set_previous_events     = { "InsertEnter" },

            -- 当二进制文件缺失时是否显示关于如何安装的通知
            keep_quiet_on_no_binary = false,

            -- 是否异步运行 `default_command` 来切换输入法
            async_switch_im         = true
        })
    end,
}
