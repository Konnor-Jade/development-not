-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

-- 保存文件
map("n", "<leader>w", "<cmd>w<cr>", { desc = "保存文件" })
-- 退出 Neovim
map("n", "q", "<cmd>q<cr>", { desc = "退出 Neovim" })
map("n", "qq", ":q!<CR>", { desc = "强制退出 Neovim" })
map("n", "Q", ":qa!<CR>", { desc = "强制退出 Neovim" })

-- insert 模式下，跳到行首行尾
map("i", "<C-h>", "<ESC>I", { desc = "跳到行首" })
map("i", "<C-l>", "<ESC>A", { desc = "跳到行尾" })

-- 保存并退出 Neovim
map("n", "<leader>wq", "<cmd>wq<cr>", { desc = "保存并退出 Neovim" })

-- 保存文件
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>", { desc = "保存文件" })


-- ; 改变为 :
map("n", ";", ":", { desc = "进入命令模式" })

-- 选择buffer pick
map("n", "<leader>p", "<cmd>BufferLinePick<CR>", { desc = "选择buffer" })

-- 选择文件
map("n", "<leader>f", "<cmd>Telescope find_files<cr>", { desc = "搜索文件(名)" })
map("n", "<leader>F", "<cmd>Telescope live_grep<cr>", { desc = "搜索文件内容" })



-- 关闭当前buffer
map("n", "<leader>x", "<cmd>bdelete<cr>", { desc = "关闭当前buffer" })
map("n", "<leader>X", "<cmd>bdelete!<cr>", { desc = "关闭其他buffer" })

-- 关闭当前窗口
map("n", "<leader>c", "<cmd>close<cr>", { desc = "关闭当前窗口" })


-- 退出 insert Modes
map("i", "jk", "<esc>", { desc = "退出 insert Modes" })

-- 打开终端
-- toggleterm
map('t', '<leader>lt', '<C-\\><C-N> <cmd>ToggleTerm<CR>', { noremap = true, silent = true })
map({ 'i', 'n' }, '<leader>lt', '<cmd>ToggleTerm<CR>', { noremap = true, silent = true })

-- 浮动终端
map({ 'n', 'i', 't' }, '<leader>t', "<cmd>Lspsaga term_toggle<CR>", { desc = "浮动终端", noremap = true, silent = true })


-- jk退出termial插入模式
map('t', 'jk', '<C-\\><C-n>', { noremap = true, silent = true })
-- 终端模式下的映射
map('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })


-- 终端模式下的映射
-- map('t', '<C-h>', '<C-\\><C-N><C-w>h', { noremap = true, silent = true })
-- map('t', '<C-j>', '<C-\\><C-N><C-w>j', { noremap = true, silent = true })
-- map('t', '<C-k>', '<C-\\><C-N><C-w>k', { noremap = true, silent = true })
-- map('t', '<C-l>', '<C-\\><C-N><C-w>l', { noremap = true, silent = true })

-- 插入模式下的映射
-- map('i', '<C-h>', '<C-\\><C-N><C-w>h', { noremap = true, silent = true })
-- map('i', '<C-j>', '<C-\\><C-N><C-w>j', { noremap = true, silent = true })
map('i', '<C-k>', '<C-\\><C-N><C-w>k', { noremap = true, silent = true })
map('i', '<C-l>', '<C-\\><C-N><C-w>l', { noremap = true, silent = true })

-- 普通模式下的映射
map('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
map('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
map('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
map('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })


-- ctrl u / ctrl + d  只移动9行，默认移动半屏
map("n", "<C-u>", "9k", { desc = "向上移动9行" })
map("n", "<C-d>", "9j", { desc = "向下移动9行" })
