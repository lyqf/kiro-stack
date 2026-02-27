#!/bin/bash
set -e

# Kiro Stack 重启脚本

echo "🔄 重启 Kiro Stack..."
echo ""

# 获取脚本所在目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 停止服务
bash "$SCRIPT_DIR/stop.sh"

echo ""
echo "⏳ 等待 2 秒..."
sleep 2
echo ""

# 启动服务
bash "$SCRIPT_DIR/start.sh"
