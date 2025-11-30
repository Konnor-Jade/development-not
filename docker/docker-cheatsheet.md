# Docker 命令速查表

## 📦 容器操作

### 运行容器

```bash
# 基本运行
docker run nginx

# 后台运行
docker run -d nginx

# 指定容器名称
docker run -d --name mynginx nginx

# 端口映射（主机端口:容器端口）
docker run -d -p 8080:80 nginx

# 挂载卷
docker run -d -v /host/path:/container/path nginx

# 环境变量
docker run -d -e "ENV_VAR=value" nginx

# 交互式运行
docker run -it ubuntu bash

# 运行后自动删除
docker run --rm ubuntu echo "Hello"

# 限制资源
docker run -d --memory="512m" --cpus="1.0" nginx

# 网络模式
docker run -d --network host nginx
docker run -d --network bridge nginx
docker run -d --network none nginx
```

### 查看容器

```bash
# 查看运行中的容器
docker ps

# 查看所有容器（包括停止的）
docker ps -a

# 显示容器大小
docker ps -s

# 只显示容器 ID
docker ps -q

# 自定义格式输出
docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}"

# 查看容器详细信息
docker inspect <container>

# 查看容器资源使用情况
docker stats

# 查看容器进程
docker top <container>
```

### 容器生命周期

```bash
# 启动容器
docker start <container>

# 停止容器
docker stop <container>

# 强制停止容器
docker kill <container>

# 重启容器
docker restart <container>

# 暂停容器
docker pause <container>

# 恢复容器
docker unpause <container>

# 删除容器
docker rm <container>

# 强制删除运行中的容器
docker rm -f <container>

# 删除所有停止的容器
docker container prune
```

### 容器交互

```bash
# 进入容器
docker exec -it <container> bash
docker exec -it <container> sh

# 在容器中执行命令
docker exec <container> ls /app

# 查看容器日志
docker logs <container>

# 实时查看日志
docker logs -f <container>

# 查看最后 100 行日志
docker logs --tail 100 <container>

# 显示时间戳
docker logs -t <container>

# 从容器复制文件到主机
docker cp <container>:/path/to/file /host/path

# 从主机复制文件到容器
docker cp /host/path <container>:/path/to/file

# 查看容器端口映射
docker port <container>
```

## 🖼️ 镜像操作

### 镜像管理

```bash
# 搜索镜像
docker search nginx

# 拉取镜像
docker pull nginx
docker pull nginx:1.24

# 查看本地镜像
docker images

# 查看镜像详细信息
docker inspect nginx

# 查看镜像历史
docker history nginx

# 删除镜像
docker rmi nginx

# 删除所有未使用的镜像
docker image prune

# 删除所有镜像
docker rmi $(docker images -q)

# 标记镜像
docker tag nginx:latest myregistry.com/nginx:v1

# 推送镜像
docker push myregistry.com/nginx:v1
```

### 构建镜像

```bash
# 从 Dockerfile 构建
docker build -t myapp:1.0 .

# 指定 Dockerfile
docker build -t myapp:1.0 -f Dockerfile.prod .

# 构建时传递参数
docker build --build-arg VERSION=1.0 -t myapp .

# 不使用缓存构建
docker build --no-cache -t myapp .

# 从容器创建镜像
docker commit <container> myapp:1.0

# 保存镜像为 tar 文件
docker save -o myapp.tar myapp:1.0

# 从 tar 文件加载镜像
docker load -i myapp.tar

# 导出容器为 tar 文件
docker export <container> > container.tar

# 从 tar 导入为镜像
docker import container.tar myapp:1.0
```

## 🔗 网络操作

```bash
# 列出网络
docker network ls

# 创建网络
docker network create mynetwork

# 删除网络
docker network rm mynetwork

# 查看网络详情
docker network inspect mynetwork

# 连接容器到网络
docker network connect mynetwork <container>

# 断开容器与网络
docker network disconnect mynetwork <container>

# 清理未使用的网络
docker network prune
```

## 💾 卷操作

```bash
# 列出卷
docker volume ls

# 创建卷
docker volume create myvolume

# 删除卷
docker volume rm myvolume

# 查看卷详情
docker volume inspect myvolume

# 清理未使用的卷
docker volume prune

# 使用卷运行容器
docker run -d -v myvolume:/data nginx
```

## 🧹 清理命令

```bash
# 删除所有停止的容器
docker container prune

# 删除所有未使用的镜像
docker image prune

# 删除所有未使用的卷
docker volume prune

# 删除所有未使用的网络
docker network prune

# 清理所有未使用的资源
docker system prune

# 清理所有未使用的资源（包括未使用的镜像）
docker system prune -a

# 查看 Docker 占用空间
docker system df
```

## 📊 监控和诊断

```bash
# 查看容器资源使用
docker stats

# 查看容器进程
docker top <container>

# 查看 Docker 事件
docker events

# 查看 Docker 系统信息
docker info

# 查看 Docker 版本
docker version

# 查看容器变更
docker diff <container>
```

## 🔐 Registry 操作

```bash
# 登录 Registry
docker login
docker login myregistry.com

# 登出
docker logout

# 推送镜像
docker push myregistry.com/myapp:1.0

# 从私有 Registry 拉取
docker pull myregistry.com/myapp:1.0
```

## 🎯 实用技巧

### 批量操作

```bash
# 停止所有容器
docker stop $(docker ps -q)

# 删除所有容器
docker rm $(docker ps -aq)

# 删除所有镜像
docker rmi $(docker images -q)

# 删除所有 <none> 镜像
docker rmi $(docker images -f "dangling=true" -q)

# 停止并删除指定前缀的容器
docker ps -a | grep "prefix" | awk '{print $1}' | xargs docker rm -f
```

### 格式化输出

```bash
# 自定义容器列表格式
docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}"

# 输出 JSON 格式
docker inspect --format='{{json .}}' <container>

# 获取容器 IP 地址
docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' <container>

# 获取容器状态
docker inspect --format='{{.State.Status}}' <container>
```

## 🔧 Dockerfile 常用指令

```dockerfile
# 基础镜像
FROM ubuntu:22.04

# 维护者信息
LABEL maintainer="your@email.com"

# 设置工作目录
WORKDIR /app

# 复制文件
COPY . /app
ADD archive.tar.gz /app

# 运行命令
RUN apt-get update && apt-get install -y nginx

# 设置环境变量
ENV NODE_ENV=production

# 暴露端口
EXPOSE 80 443

# 挂载卷
VOLUME /data

# 设置用户
USER nginx

# 启动命令
CMD ["nginx", "-g", "daemon off;"]
ENTRYPOINT ["docker-entrypoint.sh"]

# 构建参数
ARG VERSION=1.0

# 健康检查
HEALTHCHECK --interval=30s --timeout=3s \
  CMD curl -f http://localhost/ || exit 1
```

## 📝 .dockerignore 示例

```
# Git
.git
.gitignore

# 依赖
node_modules
vendor

# 构建产物
dist
build
*.log

# IDE
.vscode
.idea
*.swp

# 测试
tests
*.test.js

# 文档
README.md
docs
```

## 🚀 常用镜像

```bash
# Web 服务器
nginx:latest
httpd:latest
caddy:latest

# 应用服务器
node:20-alpine
python:3.11-slim
openjdk:17-jdk-slim
golang:1.21-alpine

# 数据库
mysql:8.0
postgres:15
mongodb:7
redis:7

# 消息队列
rabbitmq:3-management
kafka:latest

# 其他工具
busybox:latest
alpine:latest
ubuntu:22.04
```
