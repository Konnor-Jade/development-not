#!/bin/bash
# Oh My Zsh 一键安装脚本

set -e

echo "🚀 开始安装 Oh My Zsh 及常用插件..."
echo ""

# 安装 Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "📦 安装 Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "✅ Oh My Zsh 已安装"
fi

# 自定义插件目录
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# 安装 zsh-autosuggestions
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    echo "�� 安装 zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
else
    echo "✅ zsh-autosuggestions 已安装"
fi

# 安装 zsh-syntax-highlighting
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    echo "📦 安装 zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
else
    echo "✅ zsh-syntax-highlighting 已安装"
fi

# 安装 zsh-autocomplete
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autocomplete" ]; then
    echo "📦 安装 zsh-autocomplete..."
    git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git $ZSH_CUSTOM/plugins/zsh-autocomplete
else
    echo "✅ zsh-autocomplete 已安装"
fi

# 安装 you-should-use
if [ ! -d "$ZSH_CUSTOM/plugins/you-should-use" ]; then
    echo "📦 安装 you-should-use..."
    git clone https://github.com/MichaelAquilina/zsh-you-should-use.git $ZSH_CUSTOM/plugins/you-should-use
else
    echo "✅ you-should-use 已安装"
fi

echo ""
echo "✨ 安装完成！"
echo ""
echo "📝 下一步："
echo "1. 复制配置文件："
echo "   cp .zshrc ~/.zshrc"
echo ""
echo "2. 重新加载配置："
echo "   source ~/.zshrc"
echo ""
echo "3. 或者重启终端"
echo ""
echo "🎉 享受你的 Oh My Zsh！"
