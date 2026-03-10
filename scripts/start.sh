#!/bin/bash
set -e

# Kiro Stack 启动脚本

echo "🚀 启动 Kiro Stack..."

# 检查 Docker daemon 是否运行
if ! docker info > /dev/null 2>&1; then
    echo "⚠️  Docker daemon 未运行"

    # 检查是否使用 Colima (macOS)
    if command -v colima > /dev/null 2>&1; then
        echo "🔧 启动 Colima..."
        colima start
    else
        echo "❌ 请先启动 Docker daemon"
        exit 1
    fi
fi

# 启动服务
echo "📦 启动容器..."
docker compose up -d

# 等待服务就绪
echo "⏳ 等待服务就绪..."
sleep 3

# 检查服务状态
echo ""
echo "📊 服务状态:"
docker compose ps

echo ""
echo "✅ Kiro Stack 启动成功!"
echo ""
echo "📍 可用端点:"
echo "   - 管理面板: http://localhost:8099"
echo "   - OpenAI API: http://localhost:8099/v1/chat/completions"
echo "   - Anthropic API: http://localhost:8099/v1/messages"
echo ""
echo "💡 查看日志: docker compose logs -f"
