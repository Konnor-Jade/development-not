# Docker 速查手册

Docker 和 Docker Compose 常用命令速查笔记。

## 📁 文件说明

- **`docker-cheatsheet.md`** - Docker 命令速查表
- **`docker-compose-cheatsheet.md`** - Docker Compose 命令速查表
- **`docker-examples.md`** - 实用示例和最佳实践

## 🚀 快速开始

### 安装 Docker

**macOS**
```bash
brew install --cask docker
# 或下载 Docker Desktop: https://www.docker.com/products/docker-desktop
```

**Linux (Ubuntu)**
```bash
# 安装 Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# 添加用户到 docker 组
sudo usermod -aG docker $USER

# 安装 Docker Compose
sudo apt install docker-compose-plugin
```

**Windows**
下载并安装 Docker Desktop: https://www.docker.com/products/docker-desktop

### 验证安装

```bash
docker --version
docker compose version
```

## 📖 常用命令速览

### Docker 容器操作

```bash
# 运行容器
docker run -d -p 8080:80 --name mynginx nginx

# 查看运行中的容器
docker ps

# 查看所有容器（包括停止的）
docker ps -a

# 停止容器
docker stop mynginx

# 启动容器
docker start mynginx

# 删除容器
docker rm mynginx

# 查看容器日志
docker logs mynginx
```

### Docker 镜像操作

```bash
# 拉取镜像
docker pull nginx:latest

# 查看本地镜像
docker images

# 删除镜像
docker rmi nginx:latest

# 构建镜像
docker build -t myapp:1.0 .
```

### Docker Compose 操作

```bash
# 启动服务
docker compose up -d

# 停止服务
docker compose down

# 查看服务状态
docker compose ps

# 查看日志
docker compose logs -f

# 重启服务
docker compose restart
```

## 🎯 快速场景

### 场景 1: 快速启动数据库

```bash
# MySQL
docker run -d \
  --name mysql \
  -e MYSQL_ROOT_PASSWORD=root \
  -p 3306:3306 \
  mysql:8.0

# PostgreSQL
docker run -d \
  --name postgres \
  -e POSTGRES_PASSWORD=postgres \
  -p 5432:5432 \
  postgres:15

# Redis
docker run -d \
  --name redis \
  -p 6379:6379 \
  redis:7
```

### 场景 2: 使用 Docker Compose 部署应用

创建 `docker-compose.yml`:

```yaml
version: '3.8'

services:
  web:
    image: nginx:latest
    ports:
      - "8080:80"
    volumes:
      - ./html:/usr/share/nginx/html
    
  db:
    image: mysql:8.0
    environment:
      MYSQL_ROOT_PASSWORD: root
    volumes:
      - mysql_data:/var/lib/mysql

volumes:
  mysql_data:
```

运行:
```bash
docker compose up -d
```

## 📚 详细文档

- [Docker 命令速查表](./docker-cheatsheet.md) - 完整的 Docker 命令参考
- [Docker Compose 速查表](./docker-compose-cheatsheet.md) - Docker Compose 配置和命令
- [实用示例](./docker-examples.md) - 常见场景和最佳实践

## 🔗 相关资源

- [Docker 官方文档](https://docs.docker.com/)
- [Docker Hub](https://hub.docker.com/)
- [Docker Compose 文档](https://docs.docker.com/compose/)
- [Dockerfile 最佳实践](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)
