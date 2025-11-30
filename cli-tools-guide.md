# 命令行效率工具指南

实用的命令行辅助工具，提升终端使用效率。

## 📚 目录

- [tldr - 简化版命令手册](#tldr---简化版命令手册)
- [thefuck - 命令纠错工具](#thefuck---命令纠错工具)

---

## tldr - 简化版命令手册

### 📖 简介

在日常开发与运维过程中，传统的 `man` 手册过于繁琐。[tldr](https://tldr.sh/) 项目为上百个常用命令提供了简明直观的示例，极大地提升了查阅效率。

### 🚀 安装方法

#### Windows 系统

**方法一：用 Scoop 安装（推荐）**

```bash
# 安装 Scoop（如果还没装）
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
irm get.scoop.sh | iex

# 安装 tldr
scoop install tldr
```

**方法二：用 npm 安装**

```bash
npm install -g tldr
```

**方法三：用 pip 安装**

```bash
pip3 install tldr
```

#### macOS 系统

```bash
# 推荐使用 Homebrew
brew install tldr

# 或者用 npm
npm install -g tldr

# 或者用 pip
pip3 install tldr
```

#### Ubuntu / Debian 系统

```bash
# 推荐方式（snap 安装）
sudo snap install tldr

# 或者用 apt
sudo apt update
sudo apt install tldr

# 或者用 npm
npm install -g tldr

# 或者用 pip
pip3 install tldr
```

### 💡 基本使用

```bash
# 查看命令用法
tldr 命令名

# 例如：查看 tar 命令
tldr tar

# 强制更新离线文档缓存
tldr -u

# 查看有哪些命令有 tldr 页面
tldr --list

# 查看帮助信息
tldr --help
```

### 🌏 配置中文显示

#### 1. 临时使用中文

```bash
# 只对当前命令生效
LANG=zh tldr ls

# 或（部分客户端支持）
LANGUAGE=zh tldr ls
```

#### 2. 永久设置为中文

**macOS / Ubuntu / WSL**

将下方内容添加到 `~/.bashrc` 或 `~/.zshrc`：

```bash
export LANG=zh
```

保存后执行：

```bash
source ~/.bashrc  # 或 source ~/.zshrc
```

**Windows（CMD 或 PowerShell）**

CMD 中临时生效：
```cmd
set LANG=zh
tldr ls
```

长期生效：在系统环境变量或用户环境变量中添加 `LANG`，值填 `zh`。

#### 3. 更新缓存（非常重要）

修改语言后，强烈建议刷新缓存让中文页面生效：

```bash
tldr -u
```

#### 4. 验证效果

```bash
tldr cp
```

如果出现中文简明用法，表明配置成功。

### ❓ 常见问题

**部分命令还是英文？**
- 可能该命令尚未有中文翻译，建议及时更新缓存

**未知命令提示或无法联网？**
- 检查网络或采用 `tldr --update` 手动补全离线缓存

**Windows 环境变量生效问题？**
- 尝试重启终端或电脑，确认语言变量设置无误

### 🔗 相关资源

- [官方网站](https://tldr.sh/)
- [GitHub 项目](https://github.com/tldr-pages/tldr)

---

## thefuck - 命令纠错工具

### 📖 简介

[thefuck](https://github.com/nvbn/thefuck) 是一个命令行纠错工具，当你输入错误的命令时，只需输入 `fuck`，它会自动纠正上一条命令并执行正确的版本。

### ✨ 特点

- 🎯 **智能纠错**: 自动识别常见的命令错误
- 🚀 **快速执行**: 一键纠正并执行
- 🔧 **高度可配置**: 支持自定义规则
- 🌈 **多语言支持**: 支持多种 Shell
- 📦 **丰富的规则库**: 内置大量纠错规则

### 🚀 安装方法

#### macOS

```bash
# 使用 Homebrew
brew install thefuck
```

#### Ubuntu / Debian

```bash
# 使用 apt
sudo apt update
sudo apt install python3-dev python3-pip python3-setuptools
pip3 install thefuck --user
```

#### 其他 Linux 发行版

```bash
# 使用 pip
pip3 install thefuck --user
```

#### macOS / Linux 通用

```bash
# 使用 pip（推荐）
pip3 install thefuck
```

### ⚙️ 配置

安装后需要在 shell 配置文件中添加初始化脚本：

#### Bash

在 `~/.bashrc` 中添加：

```bash
eval $(thefuck --alias)
# 或自定义别名
eval $(thefuck --alias FUCK)
```

#### Zsh

在 `~/.zshrc` 中添加：

```bash
eval $(thefuck --alias)
# 或自定义别名
eval $(thefuck --alias FUCK)
```

#### Fish

在 `~/.config/fish/config.fish` 中添加：

```fish
thefuck --alias | source
```

#### PowerShell

在你的 PowerShell 配置文件中添加：

```powershell
iex "$(thefuck --alias)"
```

保存后重新加载配置：

```bash
source ~/.bashrc  # 或 source ~/.zshrc
```

### 💡 使用示例

#### 基本用法

```bash
# 输入错误的命令
$ git brnch
git: 'brnch' is not a git command. See 'git --help'.

# 输入 fuck 纠正
$ fuck
git branch [enter/↑/↓/ctrl+c]
# 自动纠正为 git branch 并执行
```

#### 更多示例

```bash
# 忘记 sudo
$ apt install vim
E: Could not open lock file...

$ fuck
sudo apt install vim [enter/↑/↓/ctrl+c]

# 拼写错误
$ gti status
bash: gti: command not found

$ fuck
git status [enter/↑/↓/ctrl+c]

# 参数顺序错误
$ git commit -m "message" -a
error: pathspec '-a' did not match any file(s)

$ fuck
git commit -a -m "message" [enter/↑/↓/ctrl+c]

# 路径错误
$ cd /uer/local
bash: cd: /uer/local: No such file or directory

$ fuck
cd /usr/local [enter/↑/↓/ctrl+c]
```

### 🎨 自定义配置

thefuck 的配置文件位于 `~/.config/thefuck/settings.py`

#### 生成配置文件

```bash
thefuck --version  # 首次运行会自动生成配置文件
```

#### 常用配置选项

```python
# ~/.config/thefuck/settings.py

# 执行前需要确认（推荐开启）
require_confirmation = True

# 等待确认的超时时间（秒）
confirm_timeout = 3.0

# 历史命令数量
history_limit = None

# 启用的规则（留空表示全部启用）
rules = []

# 排除的规则
exclude_rules = []

# 命令执行前等待时间（秒）
wait_command = 3

# 慢命令的时间阈值（秒）
slow_commands = []

# 优先级较高的规则
priority = {}

# 调试模式
debug = False

# 日志路径
log_path = '~/.config/thefuck/thefuck.log'
```

### 🔧 高级功能

#### 创建自定义别名

```bash
# 在 .bashrc 或 .zshrc 中
eval $(thefuck --alias fuck)
eval $(thefuck --alias FUCK)
eval $(thefuck --alias oops)
eval $(thefuck --alias shit)
```

#### 禁用特定规则

在配置文件中：

```python
exclude_rules = ['git_pull', 'git_push']
```

#### 查看可用规则

```bash
# 查看所有规则
thefuck --help

# 在 Python 中查看
python3 -c "from thefuck import conf; print(conf.get_rules())"
```

### ❓ 常见问题

**fuck 命令不生效？**
- 确保已添加初始化脚本到 shell 配置文件
- 重新加载配置或重启终端

**纠正建议不准确？**
- 可以在配置文件中调整规则优先级
- 或排除特定规则

**执行速度慢？**
- 减少启用的规则数量
- 调整 `slow_commands` 配置

**在某些命令后不工作？**
- 检查该命令是否在 `exclude_rules` 中
- 某些命令可能需要特定规则支持

### 🎯 实用技巧

1. **快速确认**: 直接按回车执行建议的命令
2. **查看替代方案**: 使用 ↑/↓ 箭头键查看其他建议
3. **取消执行**: 按 Ctrl+C 取消
4. **调整等待时间**: 在配置中设置 `wait_command`
5. **组合使用**: 可以和其他工具（如 `tldr`）配合使用

### 🌟 支持的纠错场景

- Git 命令错误
- 文件路径错误
- 权限不足（缺少 sudo）
- 命令拼写错误
- 参数顺序错误
- 环境变量未设置
- Python/Node.js 包管理器错误
- Docker 命令错误
- 还有更多...

### 🔗 相关资源

- [GitHub 项目](https://github.com/nvbn/thefuck)
- [官方文档](https://github.com/nvbn/thefuck/wiki)
- [规则列表](https://github.com/nvbn/thefuck/tree/master/thefuck/rules)

---

## 📝 总结

这两个工具都能极大提升命令行使用效率：

- **tldr**: 快速查看命令用法，避免翻阅冗长的 man 手册
- **thefuck**: 智能纠正命令错误，减少重新输入的麻烦

建议两者配合使用，打造高效的命令行工作环境！

## 🎓 扩展阅读

- [Oh My Zsh](https://ohmyz.sh/) - 强大的 Zsh 配置框架
- [Starship](https://starship.rs/) - 跨平台的命令行提示符（本项目已有配置）
- [fzf](https://github.com/junegunn/fzf) - 命令行模糊查找工具
- [bat](https://github.com/sharkdp/bat) - cat 的增强版，支持语法高亮
- [exa](https://github.com/ogham/exa) - ls 的现代化替代品
