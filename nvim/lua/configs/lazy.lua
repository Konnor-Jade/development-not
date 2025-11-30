-- **************************************************
-- 配置文件
-- 配置 lazy.nvim 的模块
--
-- **************************************************
-- 1. 准备lazy.nvim模块（存在性检测）
-- stdpath("data")
-- macOS/Linux: ~/.local/share/nvim
-- Windows: ~/AppData/Local/nvim-data
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim" --  lazy.nvim 的安装路径: ~/.local/share/nvim/lazy/lazy.nvim
if not vim.loop.fs_stat(lazypath) then                       -- 如果不存在，则从 GitHub 上 clone
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,          --  lazy.nvim 安装到 ~/.local/share/nvim/lazy/lazy.nvim
  })
  -- 如果克隆失败，则退出
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "克隆 lazy.nvim 失败:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\n按任意键退出..." },
    }, true, {})
    vim.fn.getchar() -- 等待用户按任意键
    os.exit(1)
  end
end

-- 2. 将 lazypath 设置为运行时路径
-- rtp（runtime path）
-- nvim进行路径搜索的时候，除已有的路径，还会从prepend的路径中查找
-- 否则，下面 require("lazy") 是找不到的
vim.opt.rtp:prepend(lazypath)

-- 确保在加载 lazy.nvim 之前设置 `mapleader` 和 `maplocalleader`
-- 这样按键映射才能正确生效
-- 这里也是设置其他配置项(vim.opt)的好地方
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 3. 加载lazy.nvim模块
-- lazy: ~/.local/share/nvim/lazy/lazy.nvim
-- 配置文件：lua/plugins/
-- "plugins" 将会加载当前目录下的 plugins.lua 目录下的所有
require("lazy").setup({
  spec = {
    { import = "plugins" }
  },
  ui = {
    icons = {
      ft = "", -- 文件类型图标
      lazy = "󰂠 ", -- 懒加载图标
      loaded = "", -- 已加载图标
      not_loaded = "", -- 未加载图标
    },
  },
  checker = {
    enabled = true,   -- 启用检查器
    notify = false,   -- 不通知
  },
  performance = {
    -- 性能优化
    rtp = {
      disabled_plugins = {
        "2html_plugin",
        "tohtml",
        "getscript",
        "getscriptPlugin",
        "gzip",
        "logipat",
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
        "matchit",
        "tar",
        "tarPlugin",
        "rrhelper",
        "spellfile_plugin",
        "vimball",
        "vimballPlugin",
        "zip",
        "zipPlugin",
        "tutor",
        "rplugin",
        "syntax",
        "synmenu",
        "optwin",
        "compiler",
        "bugreport",
        "ftplugin",
      },
    },
  },
})

-- return {
--   defaults = { lazy = true },
--   install = { colorscheme = { "nvchad" } },

--   ui = {
--     icons = {
--       ft = "",
--       lazy = "󰂠 ",
--       loaded = "",
--       not_loaded = "",
--     },
--   },

--   performance = {
--     rtp = {
--       disabled_plugins = {
--         "2html_plugin",
--         "tohtml",
--         "getscript",
--         "getscriptPlugin",
--         "gzip",
--         "logipat",
--         "netrw",
--         "netrwPlugin",
--         "netrwSettings",
--         "netrwFileHandlers",
--         "matchit",
--         "tar",
--         "tarPlugin",
--         "rrhelper",
--         "spellfile_plugin",
--         "vimball",
--         "vimballPlugin",
--         "zip",
--         "zipPlugin",
--         "tutor",
--         "rplugin",
--         "syntax",
--         "synmenu",
--         "optwin",
--         "compiler",
--         "bugreport",
--         "ftplugin",
--       },
--     },
--   },
-- }
