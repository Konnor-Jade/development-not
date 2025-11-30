# Starship 配置目录

这个目录包含了 Starship 提示符的完整配置和使用指南。

## 📁 文件说明

- **`starship.toml`** - Starship 配置文件（Gruvbox Dark 主题）
- **`starship-guide.md`** - 完整的使用指南和配置说明

## 🚀 快速使用

### 1. 安装 Starship

```bash
# macOS
brew install starship

# Linux
curl -sS https://starship.rs/install.sh | sh

# Windows (Scoop)
scoop install starship
```

### 2. 应用配置

```bash
# 创建配置目录
mkdir -p ~/.config

# 复制配置文件
cp starship.toml ~/.config/starship.toml

# 重新加载 shell
source ~/.zshrc  # 或 source ~/.bashrc
```

### 3. Shell 集成

在你的 shell 配置文件中添加初始化脚本：

**Zsh (~/.zshrc)**
```bash
eval "$(starship init zsh)"
```

**Bash (~/.bashrc)**
```bash
eval "$(starship init bash)"
```

**Fish (~/.config/fish/config.fish)**
```fish
starship init fish | source
```

## ✨ 配置特点

- **主题**: Gruvbox Dark 配色方案
- **模块化布局**: 清晰的分段显示信息
- **图标支持**: 丰富的 Nerd Font 图标
- **Git 集成**: 显示分支和状态
- **多语言支持**: 自动检测项目语言和版本
- **环境显示**: Docker、Conda、Pixi 等环境信息
- **时间显示**: 右侧显示当前时间
- **Vim 模式**: 支持 Vi 模式指示器

## 🎨 提示符布局

```
┌─ OS 图标 ─ 用户名 ─ 目录 ─ Git 信息 ─ 语言版本 ─ 环境 ─ 时间 ─┐
└─ 命令提示符 ─>
```

配色分段：
- 🟠 **橙色**: 系统信息（OS + 用户名）
- 🟡 **黄色**: 当前目录
- 🟢 **青色**: Git 分支和状态
- 🔵 **蓝色**: 编程语言版本
- ⚫ **深色**: Docker/Conda 环境
- ⚫ **灰色**: 时间显示

## 📖 详细文档

查看 [starship-guide.md](./starship-guide.md) 获取完整的配置说明和自定义技巧。

## 🎯 主要模块

### 系统信息
- OS 图标（自动识别操作系统）
- 用户名显示

### 目录显示
- 路径缩短（显示最后 3 层）
- 特殊目录图标（Documents、Downloads 等）

### Git 集成
- 分支名显示
- 状态指示器（修改、新增、删除等）
- 远程同步状态

### 编程语言
支持自动检测：
- Node.js / JavaScript
- Python
- Rust
- Go
- Java / Kotlin
- C / C++
- PHP
- Haskell

### 环境管理
- Docker 容器上下文
- Conda 虚拟环境
- Pixi 项目环境

## 🔧 自定义

配置文件 `starship.toml` 使用 TOML 格式，易于修改：

- 修改颜色主题
- 添加/删除模块
- 调整显示格式
- 自定义图标

修改后配置会自动生效（新开终端或重新加载 shell）。

## 🔗 相关资源

- [Starship 官网](https://starship.rs/)
- [配置文档](https://starship.rs/config/)
- [主题预设](https://starship.rs/presets/)
- [Nerd Fonts](https://www.nerdfonts.com/)
