local ensure_installed_list = {
    "lua",
    "python",
    "javascript",
    "go",
    "java",
    "rust",
    "typescript",
    "vim",
    "yaml",
    "json",
    "html",
    "css",
    "javascript",
    "markdown",
    "markdown_inline",
    "toml",
    "sql",
    "bash",
    "dockerfile",
    "gitignore",
}
-- 安装 treesitter
return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = { "hiphish/rainbow-delimiters.nvim" },
    event = "VeryLazy",
    main = "nvim-treesitter",
    opts = {
        ensure_installed = ensure_installed_list,
        -- stylua: ignore end
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false, -- 禁用额外的 vim 正则表达式高亮
            disable = function(_, buf)
                local max_filesize = 100 * 1024
                local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
                if ok and stats and stats.size > max_filesize then
                    return true
                end
            end,
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<CR>",
                node_incremental = "<CR>",
                node_decremental = "<BS>",
                scope_incremental = "<TAB>",
            },
        },
        indent = { -- 缩进
            enable = true,
            -- conflicts with flutter-tools.nvim, causing performance issues
            disable = { "dart" },
        },
    },
    config = function(_, opts)
        require("nvim-treesitter.install").prefer_git = true
        require("nvim-treesitter.configs").setup(opts)

        local rainbow_delimiters = require "rainbow-delimiters"

        vim.g.rainbow_delimiters = {
            strategy = {
                [""] = rainbow_delimiters.strategy["global"],
                vim = rainbow_delimiters.strategy["local"],
            },
            query = {
                [""] = "rainbow-delimiters",
                lua = "rainbow-blocks",
            },
            highlight = {
                "RainbowDelimiterRed",
                "RainbowDelimiterYellow",
                "RainbowDelimiterBlue",
                "RainbowDelimiterOrange",
                "RainbowDelimiterGreen",
                "RainbowDelimiterViolet",
                "RainbowDelimiterCyan",
            },
        }
        rainbow_delimiters.enable()

        -- 在 markdown 文件中,只有当代码设置为 scheme 时才会显示正确的高亮
        -- 但是这会导致在 neovim 中显示不正确的高亮
        -- 因此,需要将 scheme 语言链接到 query
        vim.treesitter.language.register("query", "scheme")

        vim.api.nvim_exec_autocmds("User", { pattern = "KonnorAfter nvim-treesitter" })
    end,
}
