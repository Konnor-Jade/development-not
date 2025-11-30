# Oh My Zsh 配置指南

> 强大的 Zsh 配置框架，提升终端使用体验

## 📋 目录
- [安装 Oh My Zsh](#安装-oh-my-zsh)
- [插件配置](#插件配置)
- [常用别名](#常用别名)
- [集成工具](#集成工具)
- [配置文件](#配置文件)
- [常见问题](#常见问题)

---

## 🚀 安装 Oh My Zsh

### 前置要求

```bash
# 1. 确认已安装 Zsh
zsh --version

# 2. 如果未安装，使用 Homebrew 安装
brew install zsh

# 3. 设置 Zsh 为默认 Shell
chsh -s $(which zsh)

# 4. 重启终端
```

### 安装 Oh My Zsh

```bash
# 官方安装脚本（推荐）
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# 或使用 wget
sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
```

**安装位置：** `~/.oh-my-zsh`

---

## 🔌 插件配置

### 必装插件

#### 1. git（内置）
**功能：** 提供 Git 命令的便捷别名

**常用别名：**
```bash
g       # git
ga      # git add
gaa     # git add --all
gcmsg   # git commit -m
gp      # git push
gl      # git pull
gst     # git status
gco     # git checkout
gcb     # git checkout -b
```

#### 2. zsh-autosuggestions（需安装）
**功能：** 根据历史命令提供智能建议

**安装：**
```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

**使用：**
- 输入命令时会显示灰色建议
- 按 `→` 键接受建议
- 按 `Ctrl+→` 接受一个单词

#### 3. zsh-syntax-highlighting（需安装）
**功能：** 命令行语法高亮

**安装：**
```bash
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

**特点：**
- 正确命令显示为绿色
- 错误命令显示为红色
- 参数、选项高亮显示

#### 4. zsh-autocomplete（需安装）
**功能：** 增强的自动补全

**安装：**
```bash
git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autocomplete
```

**特点：**
- 实时补全建议
- 支持模糊匹配
- 智能排序

#### 5. copypath（内置）
**功能：** 复制当前路径到剪贴板

**使用：**
```bash
copypath              # 复制当前目录路径
copypath file.txt     # 复制指定文件的绝对路径
```

#### 6. copyfile（内置）
**功能：** 复制文件内容到剪贴板

**使用：**
```bash
copyfile file.txt     # 复制文件内容
```

#### 7. copybuffer（内置）
**功能：** 复制当前命令行内容

**快捷键：**
- `Ctrl+O` - 复制当前命令行到剪贴板

#### 8. you-should-use（需安装）
**功能：** 提醒使用已定义的别名

**安装：**
```bash
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/you-should-use
```

**配置：**
```bash
# 将提示信息打印在命令输出的最后
export YSU_MESSAGE_POSITION="after"
```

**示例：**
```bash
$ git status
Found existing alias for "git status". You should use: "gst"
```

#### 9. sudo（内置）
**功能：** 快速添加 sudo 前缀

**使用：**
- 按两次 `Esc` 键，自动在当前命令前添加 `sudo`

**示例：**
```bash
# 输入命令后按两次 Esc
$ apt update
# 自动变成
$ sudo apt update
```

---

## 📝 常用别名

### 自定义别名

在 `~/.zshrc` 中添加：

```bash
# 编辑器相关
alias vim="nvim"              # 使用 Neovim
alias vi="vim"                # vi 指向 vim
alias zshconfig="nvim ~/.zshrc"  # 快速编辑配置

# 文件操作
alias ee="exa -lh"            # 更好的 ls（需安装 exa）
alias ll="ls -lh"             # 详细列表
alias la="ls -lah"            # 包含隐藏文件

# 快捷工具
alias cht="cht.sh"            # 快速查询命令（需安装 cht.sh）
alias cat="bat"               # 更好的 cat（需安装 bat）

# Git 相关
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gl="git pull"

# 项目相关
alias rr="rustrover"          # RustRover IDE
```

---

## 🛠 集成工具

### Starship 提示符

**安装：**
```bash
brew install starship
```

**配置：**
在 `~/.zshrc` 末尾添加：
```bash
eval "$(starship init zsh)"
```

**优势：**
- 极速响应
- 跨平台支持
- 高度可定制
- 显示 Git 状态、环境信息等

详见：[Starship 配置指南](../starship/)

---

### thefuck 命令纠错

**功能：** 自动纠正错误命令

**安装：**
```bash
brew install thefuck
```

**配置：**
```bash
eval $(thefuck --alias)
eval $(thefuck --alias FUCK)
```

**使用：**
```bash
$ apt update
E: Could not open lock file...

$ fuck
sudo apt update [enter/↑/↓/ctrl+c]
```

详见：[CLI 工具指南](../cli-tools-guide.md)

---

### NVM (Node Version Manager)

**安装：**
```bash
brew install nvm
```

**配置：**
```bash
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh
```

**使用：**
```bash
nvm install node       # 安装最新版 Node.js
nvm install 18         # 安装指定版本
nvm use 18             # 切换版本
nvm ls                 # 查看已安装版本
```

---

### Conda (Python 环境管理)

**配置：**
Conda 会自动添加初始化代码到 `~/.zshrc`

**常用命令：**
```bash
conda create -n myenv python=3.11   # 创建环境
conda activate myenv                # 激活环境
conda deactivate                    # 退出环境
conda env list                      # 列出所有环境
```

---

### Broot 文件管理器

**安装：**
```bash
brew install broot
```

**配置：**
```bash
source ~/.config/broot/launcher/bash/br
```

**使用：**
```bash
br              # 启动 broot
```

---

## 📄 配置文件

### 完整配置示例

将以下内容保存到 `~/.zshrc`：

```bash
# 语言设置
export LANG=zh_CN.UTF-8

# Oh My Zsh 安装路径
export ZSH="$HOME/.oh-my-zsh"

# 插件列表
plugins=(
    git                      # Git 别名
    zsh-autosuggestions      # 命令建议
    zsh-syntax-highlighting  # 语法高亮
    zsh-autocomplete         # 自动补全
    copypath                 # 复制路径
    copyfile                 # 复制文件
    copybuffer               # 复制命令行
    you-should-use           # 别名提醒
    sudo                     # sudo 快捷键
)

# 加载 Oh My Zsh
source $ZSH/oh-my-zsh.sh

# ===== 自定义配置 =====

# 编辑器别名
alias vim="nvim"
alias vi="vim"
alias zshconfig="nvim ~/.zshrc"

# 文件操作别名
alias ee="exa -lh"
alias cht="cht.sh"

# You-Should-Use 配置
export YSU_MESSAGE_POSITION="after"

# PATH 配置
export PATH="$HOME/.local/bin:$PATH"

# NVM 配置
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

# Java 配置
export JAVA_HOME=$(/usr/libexec/java_home)
export PATH=$JAVA_HOME/bin:$PATH

# Docker 补全
fpath=(~/.docker/completions $fpath)
autoload -Uz compinit
compinit

# thefuck 配置
eval $(thefuck --alias)
eval $(thefuck --alias FUCK)

# Starship 提示符
eval "$(starship init zsh)"

# Broot 文件管理器
source ~/.config/broot/launcher/bash/br

# Homebrew 镜像（中国大陆用户）
export HOMEBREW_API_DOMAIN="https://mirrors.bfsu.edu.cn/homebrew-bottles/api"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.bfsu.edu.cn/homebrew-bottles"
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.bfsu.edu.cn/git/homebrew/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.bfsu.edu.cn/git/homebrew/homebrew-core.git"
```

---

## 🔄 应用配置

修改 `~/.zshrc` 后，运行以下命令使其生效：

```bash
# 方法 1：重新加载配置
source ~/.zshrc

# 方法 2：重启终端
```

---

## ❓ 常见问题

### Q1: 插件不生效

**检查步骤：**
1. 确认插件已安装（对于第三方插件）
2. 检查 `plugins=()` 数组中是否包含插件名
3. 重新加载配置：`source ~/.zshrc`

### Q2: 终端启动速度慢

**优化建议：**
1. 减少插件数量
2. 使用 `zsh-prof` 分析启动时间
3. 延迟加载某些工具（如 nvm）

**分析启动时间：**
```bash
# 在 ~/.zshrc 开头添加
# zmodload zsh/zprof

# 在 ~/.zshrc 末尾添加
# zprof
```

### Q3: 命令不高亮

**解决方案：**
1. 确认 `zsh-syntax-highlighting` 已安装
2. 确保它在 `plugins` 数组的**最后**
3. 重新加载配置

### Q4: 自动建议不显示

**解决方案：**
1. 检查 `zsh-autosuggestions` 是否安装
2. 尝试修改建议颜色：
```bash
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=244"
```

### Q5: 权限问题

**错误信息：**
```
[oh-my-zsh] Insecure completion-dependent directories detected
```

**解决方案：**
```bash
# 修复权限
chmod 755 /opt/homebrew/share/zsh
chmod 755 /opt/homebrew/share/zsh/site-functions

# 或忽略警告（不推荐）
# ZSH_DISABLE_COMPFIX=true
```

### Q6: 更新 Oh My Zsh

```bash
# 手动更新
omz update

# 或使用脚本
cd ~/.oh-my-zsh
git pull
```

---

## 🎯 推荐配置组合

### 最小化配置
```bash
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
)
```

### 标准配置（推荐）
```bash
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-autocomplete
    copypath
    sudo
)
```

### 完整配置
```bash
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-autocomplete
    copypath
    copyfile
    copybuffer
    you-should-use
    sudo
)
```

---

## 📚 相关资源

### 官方文档
- [Oh My Zsh 官网](https://ohmyz.sh/)
- [GitHub 仓库](https://github.com/ohmyzsh/ohmyzsh)
- [插件列表](https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins)
- [主题列表](https://github.com/ohmyzsh/ohmyzsh/wiki/Themes)

### 第三方插件
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
- [zsh-autocomplete](https://github.com/marlonrichert/zsh-autocomplete)
- [you-should-use](https://github.com/MichaelAquilina/zsh-you-should-use)

### 相关工具
- [Starship](../starship/) - 提示符主题
- [thefuck](../cli-tools-guide.md) - 命令纠错
- [exa](https://github.com/ogham/exa) - 现代化 ls
- [bat](https://github.com/sharkdp/bat) - 带语法高亮的 cat

---

## 💡 使用技巧

### 1. 快速编辑配置
```bash
zshconfig  # 使用别名快速打开配置
```

### 2. 查看所有别名
```bash
alias              # 显示所有别名
alias | grep git   # 搜索 Git 相关别名
```

### 3. 禁用别名
```bash
\git status  # 使用反斜杠跳过别名
```

### 4. 临时禁用插件
```bash
# 在 ~/.zshrc 中注释掉插件
# plugins=(
#     git
#     # zsh-autosuggestions  # 临时禁用
# )
```

### 5. 插件更新
```bash
# 更新所有插件
cd ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git pull

cd ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git pull
```

---

**配置好 Oh My Zsh，让终端使用更高效！** 🚀✨
