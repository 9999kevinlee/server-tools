#!/bin/bash

# 配置项：你想要用的新端口（替换成你想要的数字）
NEW_PORT=29389

# 检查是否是 root
if [ "$EUID" -ne 0 ]; then
  echo "请以 root 身份运行此脚本。"
  exit 1
fi

echo "系统更新中..."
apt update && apt upgrade -y

echo "安装 GNOME 桌面..."
apt install ubuntu-desktop -y

echo "安装 xRDP..."
apt install xrdp -y

echo "配置 xRDP 使用新端口: $NEW_PORT"
sed -i "s/3389/$NEW_PORT/g" /etc/xrdp/xrdp.ini

echo "设置 xRDP 启动和防火墙规则..."
systemctl enable xrdp
systemctl restart xrdp
ufw allow $NEW_PORT

# 设置 session
if [ -n "$SUDO_USER" ]; then
  echo "gnome-session" > /home/$SUDO_USER/.xsession
  chown $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.xsession
else
  echo "gnome-session" > /root/.xsession
fi

echo "✅ 安装完成！你现在可以通过远程桌面连接：服务器 IP:$NEW_PORT"
