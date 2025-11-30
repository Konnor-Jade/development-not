# uv - 现代 Python 包管理工具

## 简介

uv 是由 Astral 开发的极速 Python 包管理工具，使用 Rust 编写，旨在替代 pip、pip-tools 和 virtualenv。它比传统工具快 10-100 倍，并提供更好的依赖解析能力。

## 主要特性

- ⚡ **极快速度**：比 pip 快 10-100 倍
- 🔒 **可靠的依赖解析**：准确处理复杂依赖关系
- 🎯 **兼容性强**：可作为 pip 的直接替代品
- 📦 **统一工具**：集成包管理、虚拟环境和项目管理
- 🔄 **跨平台支持**：支持 Windows、macOS 和 Linux

## 安装

### macOS/Linux
```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

### Windows
```powershell
powershell -c "irm https://astral.sh/uv/install.ps1 | iex"
```

### 使用 pip 安装
```bash
pip install uv
```

## 常用开发用法

### 1. 创建虚拟环境

```bash
# 创建虚拟环境
uv venv

# 创建指定 Python 版本的虚拟环境
uv venv --python 3.11

# 激活虚拟环境
source .venv/bin/activate  # Linux/macOS
.venv\Scripts\activate     # Windows
```

### 2. 安装包

```bash
# 安装单个包
uv pip install requests

# 安装多个包
uv pip install requests numpy pandas

# 从 requirements.txt 安装
uv pip install -r requirements.txt

# 安装开发依赖
uv pip install -r requirements-dev.txt
```

### 3. 包管理

```bash
# 列出已安装的包
uv pip list

# 显示包信息
uv pip show requests

# 卸载包
uv pip uninstall requests

# 升级包
uv pip install --upgrade requests

# 冻结依赖
uv pip freeze > requirements.txt
```

### 4. 编译依赖

```bash
# 从 requirements.in 编译精确版本
uv pip compile requirements.in -o requirements.txt

# 升级所有依赖
uv pip compile --upgrade requirements.in -o requirements.txt

# 编译指定 Python 版本的依赖
uv pip compile --python-version 3.11 requirements.in -o requirements.txt
```

### 5. 同步依赖

```bash
# 同步环境到 requirements.txt（会删除未列出的包）
uv pip sync requirements.txt
```

### 6. 项目初始化工作流

```bash
# 1. 创建项目目录
mkdir my-project && cd my-project

# 2. 创建虚拟环境
uv venv

# 3. 激活虚拟环境
source .venv/bin/activate

# 4. 创建 requirements.in
echo "requests>=2.31.0" > requirements.in
echo "pandas>=2.0.0" >> requirements.in

# 5. 编译依赖
uv pip compile requirements.in -o requirements.txt

# 6. 安装依赖
uv pip sync requirements.txt
```

### 7. 常用组合命令

```bash
# 快速安装并冻结依赖
uv pip install package-name && uv pip freeze > requirements.txt

# 编译并同步（确保环境完全匹配）
uv pip compile requirements.in -o requirements.txt && uv pip sync requirements.txt

# 升级特定包并更新 requirements.txt
uv pip install --upgrade package-name && uv pip freeze > requirements.txt
```

## 性能对比

| 操作 | pip | uv | 提升倍数 |
|------|-----|----|----|
| 安装 numpy | 5.2s | 0.1s | 52x |
| 解析依赖 | 30s | 0.3s | 100x |
| 创建虚拟环境 | 2.5s | 0.05s | 50x |

## 最佳实践

1. **使用 requirements.in + uv pip compile**：分离直接依赖和完整依赖树
2. **定期运行 uv pip compile --upgrade**：保持依赖更新
3. **在 CI/CD 中使用 uv pip sync**：确保环境一致性
4. **利用 uv 的缓存**：加速重复安装
5. **结合 .python-version**：锁定项目 Python 版本

## 与其他工具对比

| 特性 | uv | pip | poetry | pdm |
|------|----|----|--------|-----|
| 速度 | ⚡⚡⚡ | ⚡ | ⚡⚡ | ⚡⚡ |
| 依赖解析 | ✅ | ⚠️ | ✅ | ✅ |
| 锁文件 | ✅ | ❌ | ✅ | ✅ |
| 学习曲线 | 低 | 低 | 中 | 中 |

## 参考资源

- [官方文档](https://docs.astral.sh/uv/)
- [GitHub 仓库](https://github.com/astral-sh/uv)
- [发布说明](https://github.com/astral-sh/uv/releases)

## 总结

uv 是 Python 包管理的现代化解决方案，特别适合追求效率的开发者。其极快的速度和可靠的依赖解析使其成为替代 pip 的优秀选择。
