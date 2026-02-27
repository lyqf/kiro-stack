#!/bin/bash
set -e

# Kiro Stack 停止脚本

echo "🛑 停止 Kiro Stack..."

# 检查 Docker daemon 是否运行
if ! docker info > /dev/null 2>&1; then
    echo "⚠️  Docker daemon 未运行,无需停止"
    exit 0
fi

# 停止服务
echo "📦 停止容器..."
docker compose down

echo ""
echo "✅ Kiro Stack 已停止"
echo ""
echo "💡 提示:"
echo "   - 重新启动: ./scripts/start.sh"
echo "   - 停止 Docker: colima stop (macOS)"
