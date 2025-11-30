# chsrc - 全平台命令行换源工具

> 一键更换软件包管理器、编程语言和操作系统的镜像源

## 📋 简介

**chsrc** (Change Source) 是一个跨平台的命令行换源工具，支持自动测速并选择最快的镜像源。

**项目地址：** https://github.com/RubyMetric/chsrc

**支持平台：**
- Linux、Windows、macOS、BSD
- 100+ 软件和编程语言的换源

---

## 🚀 安装

### macOS
```bash
brew install chsrc
```

### Linux
```bash
# 下载最新版本
curl -L https://gitee.com/RubyMetric/chsrc/releases/download/pre/chsrc-x64-linux -o chsrc
sudo install -Dv chsrc /usr/local/bin/

# 或使用脚本安装
curl -fsSL https://gitee.com/RubyMetric/chsrc/raw/main/install.sh | bash
```

### Windows
```powershell
# 使用 Scoop
scoop install chsrc

# 或下载 exe 文件
# https://github.com/RubyMetric/chsrc/releases
```

---

## 🎯 核心用法

### 1. 查看支持的目标

```bash
# 列出所有可换源的目标
chsrc list target

# 列出所有镜像站
chsrc list mirror

# 列出按类别分类
chsrc list os        # 操作系统
chsrc list lang      # 编程语言
chsrc list ware      # 软件工具
```

### 2. 换源（推荐）

```bash
# 自动测速并选择最快源
chsrc set <target>

# 常用示例
chsrc set brew       # Homebrew
chsrc set pip        # Python pip
chsrc set npm        # Node.js npm
chsrc set ruby       # Ruby gem
chsrc set rust       # Rust cargo
chsrc set go         # Go modules
chsrc set docker     # Docker
chsrc set ubuntu     # Ubuntu APT
```

### 3. 指定镜像站换源

```bash
# 查看某目标支持的镜像站
chsrc list <target>

# 指定使用某镜像站
chsrc set <target> <mirror>

# 示例：使用清华源
chsrc set pip tuna
chsrc set npm tuna
chsrc set brew tuna
```

### 4. 测速

```bash
# 测试所有源的速度
chsrc measure <target>

# 示例
chsrc measure pip
chsrc measure npm
```

### 5. 查看当前源

```bash
# 查看当前使用的源
chsrc get <target>

# 示例
chsrc get pip
chsrc get npm
```

### 6. 重置为默认源

```bash
# 恢复上游默认源
chsrc reset <target>

# 示例
chsrc reset pip
chsrc reset npm
```

---

## 📦 常用场景

### 场景 1: 新系统初始化

```bash
# macOS 开发环境换源
chsrc set brew       # Homebrew
chsrc set pip        # Python
chsrc set npm        # Node.js
chsrc set gem        # Ruby
chsrc set cargo      # Rust

# Linux 开发环境换源
chsrc set ubuntu     # 或 debian/fedora/arch 等
chsrc set pip
chsrc set npm
chsrc set docker
```

### 场景 2: 项目级换源

```bash
# 仅为当前项目换源（支持的目标）
chsrc set -local npm
chsrc set -local pip
chsrc set -local bundler
```

### 场景 3: 测速选源

```bash
# 测速所有 pip 源
chsrc measure pip

# 根据测速结果，手动选择
chsrc set pip tuna    # 选择清华源
# 或
chsrc set pip bfsu    # 选择北外源
```

### 场景 4: 使用自定义源

```bash
# 使用自定义 URL
chsrc set pip https://mirrors.company.com/pypi/simple/
```

---

## 🎨 支持的目标（常用）

### 操作系统
- **Linux**: ubuntu, debian, fedora, arch, centos, alpine 等
- **BSD**: freebsd, openbsd, netbsd

### 编程语言
- **Python**: pip, conda, poetry
- **Node.js**: npm, yarn, pnpm
- **Ruby**: gem, bundler
- **Rust**: cargo, rustup
- **Go**: go (modules)
- **Java**: maven, gradle
- **PHP**: composer
- **Perl**: cpan
- **.NET**: nuget

### 软件工具
- **包管理器**: brew (Homebrew), scoop, chocolatey
- **容器**: docker, dockerhub
- **编辑器**: emacs, texlive
- **数据库**: mysql, postgresql, mongodb

### 镜像站（中国大陆常用）
- **tuna** - 清华大学 ⭐
- **bfsu** - 北京外国语大学 ⭐
- **ustc** - 中国科学技术大学
- **aliyun** - 阿里云
- **tencent** - 腾讯云
- **huawei** - 华为云
- **netease** - 网易

---

## ⚙️ 高级选项

```bash
# 模拟运行（不实际执行）
chsrc set -dry pip

# 本地换源（仅当前项目）
chsrc set -local npm

# 使用 IPv6 测速
chsrc set -ipv6 pip

# 英文输出
chsrc set -en pip

# 无颜色输出
chsrc set -no-color pip
```

---

## 💡 实用技巧

### 1. Homebrew 换源（macOS/Linux）

```bash
# 一键换源
chsrc set brew

# 推荐手动指定镜像（更快）
chsrc set brew bfsu    # 北外源
# 或
chsrc set brew tuna    # 清华源
```

### 2. Python 环境换源

```bash
# pip 换源
chsrc set pip

# conda 换源
chsrc set conda

# poetry 换源
chsrc set poetry
```

### 3. Node.js 生态换源

```bash
# npm 换源
chsrc set npm

# yarn 换源
chsrc set yarn

# pnpm 换源
chsrc set pnpm
```

### 4. 容器换源

```bash
# Docker Hub 换源
chsrc set dockerhub

# Docker CE 换源
chsrc set docker
```

### 5. 查看帮助

```bash
# 查看某目标的详细信息
chsrc list pip

# 查看完整帮助
chsrc help
```

---

## 📝 配置持久化

chsrc 会自动修改配置文件，更改是永久的：

| 目标 | 配置文件位置 |
|------|-------------|
| pip | `~/.pip/pip.conf` |
| npm | `~/.npmrc` |
| gem | `~/.gemrc` |
| cargo | `~/.cargo/config.toml` |
| brew | 环境变量 (在 ~/.zshrc) |
| go | `GOPROXY` 环境变量 |

---

## 🔧 与其他工具对比

| 功能 | chsrc | 手动配置 | 其他工具 |
|------|-------|---------|---------|
| 自动测速 | ✅ | ❌ | 部分支持 |
| 跨平台 | ✅ | ❌ | 部分支持 |
| 支持目标多 | ✅ (100+) | ✅ | 有限 |
| 操作简单 | ✅ | ❌ | 一般 |
| 撤销方便 | ✅ | ❌ | 一般 |

---

## ❓ 常见问题

### Q1: chsrc 安全吗？

✅ **安全**
- 开源项目，代码可审查
- 只修改配置文件，不涉及系统核心
- 不需要 root 权限（除非是系统级换源）

### Q2: 换源后如何恢复？

```bash
# 方法 1: 使用 chsrc 重置
chsrc reset <target>

# 方法 2: 手动删除配置
# pip: 删除 ~/.pip/pip.conf
# npm: 删除 ~/.npmrc 中的 registry 行
```

### Q3: 测速不准怎么办？

```bash
# 使用 IPv6 测速（如果你的网络支持）
chsrc measure -ipv6 pip

# 或手动选择稳定的镜像站
chsrc set pip tuna    # 清华源
chsrc set pip bfsu    # 北外源
```

### Q4: 某些目标不支持本地换源

```bash
# 查看支持的功能
chsrc list <target>

# 会显示该目标支持的选项
# ✓ = 支持, ✗ = 不支持
```

### Q5: 换源后还是很慢？

可能原因：
1. 镜像站本身速度慢 → 尝试其他镜像
2. 网络问题 → 检查网络连接
3. DNS 问题 → 尝试更换 DNS

```bash
# 测试所有源的速度
chsrc measure <target>

# 选择测速最快的源
```

---

## 🌟 推荐配置

### macOS 开发环境

```bash
# Homebrew（重要！）
chsrc set brew bfsu

# Python
chsrc set pip bfsu

# Node.js
chsrc set npm bfsu

# Rust
chsrc set cargo bfsu
chsrc set rustup bfsu

# Ruby
chsrc set gem bfsu
```

### Linux 开发环境

```bash
# 系统包管理器（根据发行版选择）
chsrc set ubuntu     # Ubuntu/Debian
# 或
chsrc set arch       # Arch Linux

# 开发工具
chsrc set pip bfsu
chsrc set npm bfsu
chsrc set docker bfsu
chsrc set dockerhub bfsu
```

---

## 📚 相关资源

- **官方仓库**: https://github.com/RubyMetric/chsrc
- **Gitee 镜像**: https://gitee.com/RubyMetric/chsrc
- **问题反馈**: https://github.com/RubyMetric/chsrc/issues

---

## 🎉 总结

chsrc 的优势：
- ✅ **一键换源** - 简单快捷
- ✅ **自动测速** - 智能选择最快源
- ✅ **跨平台** - Windows/macOS/Linux 通用
- ✅ **支持广泛** - 100+ 目标支持
- ✅ **开源免费** - GPLv3+ 许可

**推荐使用场景：**
- 🆕 新系统初始化
- 🌏 网络环境切换（国内/国外）
- 🚀 加速软件包下载
- 🔧 批量配置开发环境

**一行命令，提速开发！** ⚡✨
