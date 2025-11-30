# Docker Compose 速查表

## 🚀 基本命令

### 服务管理

```bash
# 启动服务（前台）
docker compose up

# 启动服务（后台）
docker compose up -d

# 停止并删除容器、网络
docker compose down

# 停止并删除所有（包括卷）
docker compose down -v

# 停止服务（不删除容器）
docker compose stop

# 启动已停止的服务
docker compose start

# 重启服务
docker compose restart

# 暂停服务
docker compose pause

# 恢复服务
docker compose unpause
```

### 构建和拉取

```bash
# 构建服务镜像
docker compose build

# 不使用缓存构建
docker compose build --no-cache

# 构建指定服务
docker compose build web

# 拉取服务镜像
docker compose pull

# 启动前先构建
docker compose up --build
```

### 查看和监控

```bash
# 查看服务状态
docker compose ps

# 查看所有容器（包括停止的）
docker compose ps -a

# 查看服务日志
docker compose logs

# 实时查看日志
docker compose logs -f

# 查看指定服务日志
docker compose logs -f web

# 查看配置
docker compose config

# 验证配置文件
docker compose config --quiet
```

### 服务操作

```bash
# 在服务中执行命令
docker compose exec web bash

# 运行一次性命令
docker compose run web python manage.py migrate

# 运行命令后删除容器
docker compose run --rm web bash

# 扩展服务实例数量
docker compose up -d --scale web=3

# 查看服务进程
docker compose top
```

## 📝 docker-compose.yml 配置

### 基本结构

```yaml
version: '3.8'

services:
  web:
    image: nginx:latest
    ports:
      - "8080:80"
    volumes:
      - ./html:/usr/share/nginx/html
    environment:
      - NODE_ENV=production
    depends_on:
      - db
    restart: unless-stopped

  db:
    image: postgres:15
    environment:
      POSTGRES_PASSWORD: postgres
    volumes:
      - postgres_data:/var/lib/postgresql/data

volumes:
  postgres_data:

networks:
  default:
    driver: bridge
```

### 服务配置完整示例

```yaml
version: '3.8'

services:
  web:
    # 使用镜像
    image: nginx:latest
    
    # 或从 Dockerfile 构建
    build:
      context: .
      dockerfile: Dockerfile
      args:
        VERSION: 1.0
    
    # 容器名称
    container_name: my-web
    
    # 端口映射
    ports:
      - "8080:80"
      - "443:443"
    
    # 卷挂载
    volumes:
      - ./html:/usr/share/nginx/html
      - nginx_logs:/var/log/nginx
    
    # 环境变量
    environment:
      - NODE_ENV=production
      - DEBUG=false
    
    # 从文件读取环境变量
    env_file:
      - .env
    
    # 依赖关系
    depends_on:
      - db
      - redis
    
    # 网络
    networks:
      - frontend
      - backend
    
    # 重启策略
    restart: unless-stopped
    
    # 命令覆盖
    command: nginx -g 'daemon off;'
    
    # 工作目录
    working_dir: /app
    
    # 用户
    user: nginx
    
    # 健康检查
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 40s

volumes:
  nginx_logs:

networks:
  frontend:
  backend:
```

## 🎯 实用配置示例

### Web 应用 + 数据库

```yaml
version: '3.8'

services:
  web:
    build: .
    ports:
      - "3000:3000"
    environment:
      - DATABASE_URL=postgres://user:pass@db:5432/mydb
    depends_on:
      - db
    volumes:
      - .:/app
      - /app/node_modules
    restart: unless-stopped

  db:
    image: postgres:15
    environment:
      POSTGRES_USER: user
      POSTGRES_PASSWORD: pass
      POSTGRES_DB: mydb
    volumes:
      - postgres_data:/var/lib/postgresql/data
    restart: unless-stopped

volumes:
  postgres_data:
```

### 前端 + 后端 + 数据库

```yaml
version: '3.8'

services:
  frontend:
    build: ./frontend
    ports:
      - "80:80"
    depends_on:
      - backend
    networks:
      - frontend_net

  backend:
    build: ./backend
    ports:
      - "8000:8000"
    environment:
      - DATABASE_URL=mysql://root:root@db:3306/mydb
    depends_on:
      - db
      - redis
    networks:
      - frontend_net
      - backend_net
    restart: unless-stopped

  db:
    image: mysql:8.0
    environment:
      MYSQL_ROOT_PASSWORD: root
      MYSQL_DATABASE: mydb
    volumes:
      - mysql_data:/var/lib/mysql
    networks:
      - backend_net
    restart: unless-stopped

  redis:
    image: redis:7-alpine
    networks:
      - backend_net
    restart: unless-stopped

volumes:
  mysql_data:

networks:
  frontend_net:
  backend_net:
```

### 开发环境完整示例

```yaml
version: '3.8'

services:
  nginx:
    image: nginx:alpine
    ports:
      - "80:80"
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf:ro
    depends_on:
      - web
    networks:
      - frontend
    restart: unless-stopped

  web:
    build:
      context: ./app
      dockerfile: Dockerfile
    volumes:
      - ./app:/app
      - /app/node_modules
    environment:
      - NODE_ENV=development
    networks:
      - frontend
      - backend
    restart: unless-stopped

  postgres:
    image: postgres:15-alpine
    environment:
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
      POSTGRES_DB: mydb
    volumes:
      - postgres_data:/var/lib/postgresql/data
    ports:
      - "5432:5432"
    networks:
      - backend
    restart: unless-stopped

  redis:
    image: redis:7-alpine
    volumes:
      - redis_data:/data
    ports:
      - "6379:6379"
    networks:
      - backend
    restart: unless-stopped

volumes:
  postgres_data:
  redis_data:

networks:
  frontend:
    driver: bridge
  backend:
    driver: bridge
```

## 🔧 常用配置选项

### 环境变量

```yaml
services:
  web:
    # 方式 1: 直接定义
    environment:
      - NODE_ENV=production
      - PORT=3000
    
    # 方式 2: 对象形式
    environment:
      NODE_ENV: production
      PORT: 3000
    
    # 方式 3: 从文件读取
    env_file:
      - .env
      - .env.prod
```

### 卷挂载

```yaml
services:
  web:
    volumes:
      # 绑定挂载（主机路径:容器路径）
      - ./app:/app
      
      # 命名卷
      - data_volume:/data
      
      # 匿名卷
      - /app/node_modules
      
      # 只读挂载
      - ./config:/config:ro
```

### 网络配置

```yaml
services:
  web:
    networks:
      frontend:
        ipv4_address: 172.20.0.5
      backend:
        aliases:
          - web-api

networks:
  frontend:
    driver: bridge
    ipam:
      config:
        - subnet: 172.20.0.0/16
  backend:
    driver: bridge
```

### 健康检查

```yaml
services:
  web:
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost"]
      interval: 1m
      timeout: 10s
      retries: 3
      start_period: 40s
```

## 🛠️ 高级用法

### 多环境配置

```bash
# 使用不同的 compose 文件
docker compose -f docker-compose.yml -f docker-compose.dev.yml up

# 生产环境
docker compose -f docker-compose.yml -f docker-compose.prod.yml up
```

### 使用 .env 文件

**.env**
```bash
# 数据库配置
DB_HOST=postgres
DB_PORT=5432
DB_NAME=mydb

# 应用配置
APP_PORT=3000
NODE_ENV=production
```

**docker-compose.yml**
```yaml
version: '3.8'

services:
  web:
    ports:
      - "${APP_PORT}:3000"
    environment:
      - NODE_ENV=${NODE_ENV}
      - DB_HOST=${DB_HOST}
```

### 扩展和复用配置

```yaml
version: '3.8'

x-common-variables: &common-env
  TZ: Asia/Shanghai
  LOG_LEVEL: info

x-restart-policy: &restart-policy
  restart: unless-stopped

services:
  web:
    <<: *restart-policy
    environment:
      <<: *common-env
      APP_NAME: web
  
  api:
    <<: *restart-policy
    environment:
      <<: *common-env
      APP_NAME: api
```

## 📊 监控和调试

```bash
# 查看容器输出
docker compose logs -f

# 查看指定服务的日志
docker compose logs -f web db

# 显示时间戳
docker compose logs -t

# 查看服务进程
docker compose top

# 查看服务配置
docker compose config

# 查看服务端口
docker compose port web 3000

# 查看服务事件
docker compose events
```

## 🎯 最佳实践

1. **使用 .dockerignore** - 减少构建上下文
2. **多阶段构建** - 减小镜像大小
3. **使用环境变量** - 配置灵活性
4. **健康检查** - 确保服务可用
5. **资源限制** - 防止资源耗尽
6. **网络隔离** - 提高安全性
7. **卷管理** - 数据持久化
8. **使用 .env 文件** - 敏感信息分离
9. **版本固定** - 镜像标签不用 latest
10. **日志管理** - 控制日志大小
