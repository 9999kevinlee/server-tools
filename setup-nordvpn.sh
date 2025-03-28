#!/bin/bash

# 1. 安装 NordVPN 官方仓库
echo "🔧 添加 NordVPN 仓库..."
sh <(curl -sSf https://downloads.nordcdn.com/apps/linux/install.sh)

# 2. 登录（手动）
echo "🔐 请登录你的 NordVPN 账户..."
nordvpn login

# 3. 等待登录完成
read -p "✅ 登录完成后按 Enter 继续..."

# 4. 添加白名单：SSH 和 xRDP 端口
echo "🔒 添加远程连接白名单..."
nordvpn whitelist add port 22     # SSH
nordvpn whitelist add port 29389  # xRDP（你当前远程桌面端口）

# 可选：添加子网白名单（比如内网通信）
# nordvpn whitelist add subnet 192.168.0.0/16

# 5. 设置为不更改 DNS（避免干扰）
nordvpn set dns disabled

# 6. 连接一个 VPN 节点（默认智能选择）
echo "🌐 正在连接 NordVPN 节点..."
nordvpn connect

# 7. 显示状态
echo
nordvpn status

echo "✅ NordVPN 已连接，xRDP 和 SSH 保持通畅。你现在可以安心使用 VPN 功能了 😎"
