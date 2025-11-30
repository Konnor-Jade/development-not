local opt = vim.opt -- global options
local g = vim.g     -- global options
local o = vim.o     -- global options
local wo = vim.wo   -- window-local options
local bo = vim.bo   -- buffer-local options

-- 使用 vim.api.nvim_create_autocmd 来安全地设置缓冲区选项
vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        -- 如果查找的内容中不存在大写，则大小写不敏感
        opt.ignorecase = true
        opt.smartcase = true

        -- 不要在查找之后继续高亮匹配结果
        opt.hlsearch = false

        -- 设置搜索时高亮匹配
        opt.hlsearch = true
    end
})

-- 所以模式添加鼠标支持
opt.mouse = "a"
opt.mousemodel = "extend" -- 鼠标扩展模式

-- 禁止创建备份文件
opt.backup = false
opt.writebackup = false
opt.swapfile = false


-- 启用终端颜色
opt.termguicolors = true

-- 等待键盘快捷键连击时间500毫秒
opt.timeoutlen = 500

-- 在搜索计数前不显示字符 "W"
opt.shortmess = o.shortmess .. "s"

-- 补全最多显示16行
opt.pumheight = 16

-- 数字格式
opt.nrformats = "bin,hex,alpha"

-- utf8
g.encoding = "UTF-8"
o.fileencoding = 'utf-8'
-- jkhl 移动时光标周围保留8行
o.scrolloff = 8
o.sidescrolloff = 8
-- 使用相对行号
wo.number = true
wo.relativenumber = true
-- 高亮所在行
wo.cursorline = true
-- 显示左侧图标指示列
wo.signcolumn = "yes"
-- 右侧参考线，超过表示代码太长了，考虑换行
wo.colorcolumn = "80"
-- 缩进2个空格等于一个Tab
o.tabstop = 4
bo.tabstop = 4
o.softtabstop = 4
o.shiftround = true
-- >> << 时移动长度
o.shiftwidth = 4
bo.shiftwidth = 4
-- 使用实际的Tab字符而不是空格 (对于Go等使用Tab的语言)
-- o.expandtab = true
-- bo.expandtab = true
o.expandtab = false
bo.expandtab = false
-- 新行对齐当前行
o.autoindent = true
bo.autoindent = true
o.smartindent = true
-- 搜索大小写不敏感，除非包含大写
o.ignorecase = true
o.smartcase = true
-- 搜索不要高亮
o.hlsearch = false
-- 边输入边搜索
o.incsearch = true
-- 命令行高为2，提供足够的显示空间
o.cmdheight = 2
-- 当文件被外部程序修改时，自动加载
o.autoread = true
bo.autoread = true
-- 禁止折行
wo.wrap = false
-- 光标在行首尾时<Left><Right>可以跳到下一行
o.whichwrap = '<,>,[,]'
-- 允许隐藏被修改过的buffer
o.hidden = true

-- 禁止创建备份文件
o.backup = false
o.writebackup = false
o.swapfile = false
-- smaller updatetime
o.updatetime = 300
-- 设置 timeoutlen 为等待键盘快捷键连击时间500毫秒，可根据需要设置
o.timeoutlen = 500
-- split window 从下边和右边出现
o.splitbelow = true
o.splitright = true
-- 自动补全不自动选中
g.completeopt = "menu,menuone,noselect,noinsert"
-- 样式
o.background = "dark"
o.termguicolors = true
opt.termguicolors = true
-- 不可见字符的显示，显示空格为点，Tab为竖线和短横线
o.list = true
o.listchars = "space:·,tab:│ "
-- 补全增强
o.wildmenu = true
-- Dont' pass messages to |ins-completin menu|
o.shortmess = o.shortmess .. 'c'
-- 补全最多显示10行
o.pumheight = 10
-- 永远显示 tabline
o.showtabline = 2
-- 使用增强状态栏插件后不再需要 vim 的模式提示
o.showmode = false
