#!/bin/bash

echo "🔧 开始安装中文语言包和拼音输入法..."

# 安装中文语言包
sudo apt update
sudo apt install -y language-pack-zh-hans

# 安装 ibus 框架和拼音输入法相关包
sudo apt install -y ibus ibus-pinyin ibus-clutter ibus-gtk ibus-gtk3

# 设置环境变量（输入法相关）
echo 'export GTK_IM_MODULE=ibus' >> ~/.profile
echo 'export QT_IM_MODULE=ibus' >> ~/.profile
echo 'export XMODIFIERS="@im=ibus"' >> ~/.profile

# 重启 ibus 服务
ibus restart || echo "ibus 暂时还未启动，重启系统后会生效"

echo "✅ 已完成安装和配置，建议现在重启系统以生效。"

# 提示用户下一步操作
echo
echo "🔁 重启系统后，进入桌面打开 Settings → Region & Language → Input Sources → 添加 Chinese / Pinyin 输入法。"
echo "然后你就可以用 'Win + 空格' 切换中英文输入啦！"
