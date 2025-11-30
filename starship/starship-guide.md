# Starship 使用指南

## 📖 简介

Starship 是一个快速、可定制的跨平台 shell 提示符工具，用 Rust 编写，性能出色。它支持任何 shell（Zsh、Bash、Fish、PowerShell 等），并能自动检测项目环境显示相关信息。

## 🎯 为什么选择 Starship

- ⚡ **极速**: 用 Rust 编写，启动和渲染都非常快
- 🎨 **美观**: 丰富的主题和图标支持
- 🔧 **易配置**: TOML 格式配置文件，简单明了
- 🌐 **跨平台**: 支持所有主流操作系统和 Shell
- 🔌 **智能**: 自动检测项目类型和工具链
- 💡 **信息丰富**: 显示 Git、语言版本、环境等信息

## 🚀 安装步骤

### macOS

```bash
# 使用 Homebrew
brew install starship

# 安装 Nerd Font（必需，用于显示图标）
brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font
# 或
brew install --cask font-jetbrains-mono-nerd-font
```

### Linux

```bash
# 使用安装脚本
curl -sS https://starship.rs/install.sh | sh

# 或使用包管理器
# Arch Linux
sudo pacman -S starship

# Ubuntu/Debian
sudo apt install starship

# Fedora
sudo dnf install starship
```

### Windows

```powershell
# 使用 Scoop
scoop install starship

# 使用 Chocolatey
choco install starship

# 使用 winget
winget install --id Starship.Starship
```

## ⚙️ Shell 集成

### Zsh

在 `~/.zshrc` 末尾添加：

```bash
eval "$(starship init zsh)"
```

### Bash

在 `~/.bashrc` 末尾添加：

```bash
eval "$(starship init bash)"
```

### Fish

在 `~/.config/fish/config.fish` 末尾添加：

```fish
starship init fish | source
```

### PowerShell

在 PowerShell 配置文件中添加：

```powershell
Invoke-Expression (&starship init powershell)
```

## 📝 配置文件详解

### 配置文件位置

```bash
~/.config/starship.toml  # Linux/macOS
%USERPROFILE%\.config\starship.toml  # Windows
```

### 基本结构

```toml
# 定义提示符格式
format = """
[模块1]
[模块2]
$line_break
$character
"""

# 配色方案
palette = 'gruvbox_dark'

# 模块配置
[module_name]
disabled = false
style = "color"
format = "格式字符串"
```

### 当前配置解析

#### 1. 格式定义

```toml
format = """
[](color_orange)\
$os\
$username\
[](bg:color_yellow fg:color_orange)\
$directory\
...
"""
```

- 使用 powerline 风格的分段符号
- `$module` 引用模块
- `[]()` 定义颜色和样式
- `\` 续行符

#### 2. 颜色方案 (Gruvbox Dark)

```toml
[palettes.gruvbox_dark]
color_fg0 = '#fbf1c7'     # 前景色（浅色）
color_bg1 = '#3c3836'     # 背景色 1（深色）
color_bg3 = '#665c54'     # 背景色 3（中深）
color_blue = '#458588'    # 蓝色
color_aqua = '#689d6a'    # 青色
color_green = '#98971a'   # 绿色
color_orange = '#d65d0e'  # 橙色
color_purple = '#b16286'  # 紫色
color_red = '#cc241d'     # 红色
color_yellow = '#d79921'  # 黄色
```

#### 3. 操作系统模块

```toml
[os]
disabled = false
style = "bg:color_orange fg:color_fg0"

[os.symbols]
Macos = "󰀵"
Linux = "󰌽"
Windows = "󰍲"
# ... 更多系统图标
```

显示当前操作系统图标。

#### 4. 用户名模块

```toml
[username]
show_always = true
style_user = "bg:color_orange fg:color_fg0"
style_root = "bg:color_orange fg:color_fg0"
format = '[ $user ]($style)'
```

始终显示用户名，root 用户也用相同样式。

#### 5. 目录模块

```toml
[directory]
style = "fg:color_fg0 bg:color_yellow"
format = "[ $path ]($style)"
truncation_length = 3        # 显示最后 3 层目录
truncation_symbol = "…/"     # 省略符号

[directory.substitutions]
"Documents" = "󰈙 "
"Downloads" = " "
"Music" = "󰝚 "
"Pictures" = " "
"Developer" = "󰲋 "
```

用图标替换特定目录名，路径过长时自动截断。

#### 6. Git 模块

```toml
[git_branch]
symbol = ""
style = "bg:color_aqua"
format = '[[ $symbol $branch ](fg:color_fg0 bg:color_aqua)]($style)'

[git_status]
style = "bg:color_aqua"
format = '[[($all_status$ahead_behind )](fg:color_fg0 bg:color_aqua)]($style)'
```

显示 Git 分支和状态：
- `✓` 已提交
- `+` 新增文件
- `~` 修改文件
- `-` 删除文件
- `⇡` 领先远程
- `⇣` 落后远程

#### 7. 编程语言模块

所有语言模块统一格式：

```toml
[language]
symbol = "图标"
style = "bg:color_blue"
format = '[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)'
```

支持的语言：
- **Node.js**: ``
- **Python**: ``
- **Rust**: ``
- **Go**: ``
- **Java**: ``
- **C/C++**: ` / `
- **PHP**: ``
- **Kotlin**: ``
- **Haskell**: ``

#### 8. 环境模块

```toml
[docker_context]
symbol = ""
style = "bg:color_bg3"
format = '[[ $symbol( $context) ](fg:#83a598 bg:color_bg3)]($style)'

[conda]
style = "bg:color_bg3"
format = '[[ $symbol( $environment) ](fg:#83a598 bg:color_bg3)]($style)'

[pixi]
style = "bg:color_bg3"
format = '[[ $symbol( $version)( $environment) ](fg:color_fg0 bg:color_bg3)]($style)'
```

显示 Docker、Conda、Pixi 等环境信息。

#### 9. 时间模块

```toml
[time]
disabled = false
time_format = "%R"          # 24 小时格式 HH:MM
style = "bg:color_bg1"
format = '[[  $time ](fg:color_fg0 bg:color_bg1)]($style)'
```

#### 10. 命令提示符

```toml
[character]
success_symbol = '[](bold fg:color_green)'     # 成功：绿色箭头
error_symbol = '[](bold fg:color_red)'         # 失败：红色箭头
vimcmd_symbol = '[](bold fg:color_green)'      # Vim 命令模式
vimcmd_visual_symbol = '[](bold fg:color_yellow)' # Vim 可视模式
```

## 🎨 自定义技巧

### 1. 修改颜色主题

创建自定义配色：

```toml
[palettes.my_theme]
primary = '#e06c75'
secondary = '#98c379'
background = '#282c34'

palette = 'my_theme'
```

### 2. 调整目录显示

```toml
[directory]
truncation_length = 5        # 显示 5 层
truncate_to_repo = true      # Git 仓库内从根目录显示
home_symbol = '~'            # 家目录符号
```

### 3. 添加新模块

```toml
format = """
...
$custom_module
...
"""

[custom.custom_module]
command = "echo 你好"
when = true
style = "bold green"
format = "[$output]($style)"
```

### 4. 禁用不需要的模块

```toml
[nodejs]
disabled = true

[python]
disabled = true
```

### 5. 修改 Git 状态符号

```toml
[git_status]
ahead = '⇡${count}'
behind = '⇣${count}'
diverged = '⇕⇡${ahead_count}⇣${behind_count}'
conflicted = '='
deleted = '✘'
renamed = '»'
modified = '!'
staged = '+'
untracked = '?'
```

## 🔧 常见问题

### 1. 图标显示为方块或问号

**原因**: 未安装 Nerd Font 字体

**解决**:
```bash
# macOS
brew install --cask font-hack-nerd-font

# 然后在终端设置中选择 Nerd Font
```

### 2. 配置未生效

```bash
# 检查配置文件语法
starship config

# 重新加载 shell
source ~/.zshrc  # 或 source ~/.bashrc
```

### 3. 提示符太慢

```bash
# 打印模块加载时间
starship timings

# 禁用慢速模块
[slow_module]
disabled = true
```

### 4. 提示符在小窗口显示不全

```toml
# 移除部分模块或调整格式
format = """
$directory
$git_branch
$character
"""
```

## 💡 实用技巧

### 1. 创建多套配置

```bash
# 工作配置
export STARSHIP_CONFIG=~/.config/starship-work.toml

# 个人配置
export STARSHIP_CONFIG=~/.config/starship-personal.toml
```

### 2. 根据目录切换配置

在 `.zshrc` 中：

```bash
precmd() {
  if [[ $PWD == /work/* ]]; then
    export STARSHIP_CONFIG=~/.config/starship-work.toml
  else
    export STARSHIP_CONFIG=~/.config/starship.toml
  fi
}
```

### 3. 快速预览主题

```bash
# 使用预设主题
starship preset nerd-font-symbols -o ~/.config/starship.toml
starship preset gruvbox-rainbow -o ~/.config/starship.toml
starship preset tokyo-night -o ~/.config/starship.toml
```

### 4. 调试配置

```bash
# 显示所有配置
starship print-config

# 解释配置
starship explain
```

## 📊 性能优化

### 1. 限制 Git 状态检查

```toml
[git_status]
disabled = false
ignore_submodules = true     # 忽略子模块
```

### 2. 使用缓存

Starship 默认会缓存命令输出，一般无需手动配置。

### 3. 异步加载

```toml
# 大部分模块默认异步加载
[nodejs]
detect_files = ['package.json']  # 仅在有此文件时检测
```

## 🌟 推荐配置组合

### 极简配置

```toml
format = """
$directory\
$git_branch\
$character
"""

[directory]
truncation_length = 3

[git_branch]
format = "[$branch]($style) "

[character]
success_symbol = "[❯](bold green)"
error_symbol = "[❯](bold red)"
```

### 完整开发配置

```toml
format = """
$username\
$hostname\
$directory\
$git_branch\
$git_status\
$python\
$nodejs\
$rust\
$golang\
$docker_context\
$line_break\
$character
"""
```

## 📚 参考资源

- [Starship 官方文档](https://starship.rs/)
- [配置参考](https://starship.rs/config/)
- [预设主题](https://starship.rs/presets/)
- [GitHub 仓库](https://github.com/starship/starship)
- [Nerd Fonts 图标查询](https://www.nerdfonts.com/cheat-sheet)

## 🎯 配置总结

本配置的特点：

- ✅ **Gruvbox Dark 主题**: 经典的深色配色
- ✅ **Powerline 风格**: 美观的分段显示
- ✅ **完整的语言支持**: 10+ 种编程语言
- ✅ **环境感知**: Docker、Conda、Pixi
- ✅ **Git 集成**: 分支和状态一目了然
- ✅ **时间显示**: 右侧显示当前时间
- ✅ **Vim 模式支持**: 不同模式不同提示符
- ✅ **高性能**: Rust 实现，极速响应

根据个人喜好可继续调整 `~/.config/starship.toml`！
