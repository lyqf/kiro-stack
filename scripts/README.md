# Kiro Stack 管理脚本

这个目录包含用于管理 Kiro Stack 服务的便捷脚本。

## 脚本列表

### 🚀 start.sh - 启动服务

启动 Kiro Stack 的所有服务(kiro-go 和 kiro-gateway)。

```bash
./scripts/start.sh
```

**功能:**
- 自动检测 Docker daemon 状态
- 如果 Docker 未运行,自动启动 Colima (macOS)
- 启动所有容器
- 显示服务状态和可用端点

### 🛑 stop.sh - 停止服务

停止所有 Kiro Stack 服务。

```bash
./scripts/stop.sh
```

**功能:**
- 优雅停止所有容器
- 清理 Docker 网络
- 保留数据卷(data/config.json 等)

### 🔄 restart.sh - 重启服务

重启所有服务(先停止再启动)。

```bash
./scripts/restart.sh
```

**功能:**
- 调用 stop.sh 停止服务
- 等待 2 秒
- 调用 start.sh 重新启动服务

## 使用场景

### 开发场景

```bash
# 修改代码后重新构建并启动
docker compose up -d --build
./scripts/restart.sh

# 查看日志
docker compose logs -f

# 只查看某个服务的日志
docker compose logs -f kiro-go
docker compose logs -f kiro-gateway
```

### 配置更新

```bash
# 修改 .env 或 config.json 后
./scripts/restart.sh
```

### 故障排查

```bash
# 完全重启服务
./scripts/restart.sh

# 查看详细日志
docker compose logs -f --tail=100
```

## 服务端点

启动成功后,以下端点可用:

- **管理面板**: http://localhost:8088
- **OpenAI 兼容 API**: http://localhost:8088/v1/chat/completions
- **Anthropic 兼容 API**: http://localhost:8088/v1/messages
- **Gateway 直接访问**: http://localhost:8001 (仅用于调试)

## 注意事项

1. **权限**: 脚本需要可执行权限 (`chmod +x scripts/*.sh`)
2. **Docker**: 需要 Docker 或 Colima 已安装
3. **端口**: 确保 8088 和 8001 端口未被占用
4. **数据持久化**: `data/config.json` 会在容器重启后保留

## 故障排除

### Docker daemon 未运行

```bash
# macOS (Colima)
colima start

# 或使用 Docker Desktop
open -a Docker
```

### 端口被占用

```bash
# 查看端口占用
lsof -i :8088
lsof -i :8001

# 停止占用端口的进程
kill -9 <PID>
```

### 容器启动失败

```bash
# 查看详细日志
docker compose logs

# 重新构建镜像
docker compose up -d --build --force-recreate
```

## 其他有用的命令

```bash
# 查看容器状态
docker compose ps

# 进入容器 shell
docker compose exec kiro-go sh
docker compose exec kiro-gateway bash

# 清理所有数据(危险!)
docker compose down -v

# 仅重启单个服务
docker compose restart kiro-go
docker compose restart kiro-gateway
```
