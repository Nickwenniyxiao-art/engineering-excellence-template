# RUNBOOK（运维应急手册模板）

> 请按项目实际情况替换以下占位符：
> - `<PROJECT>_medusa`
> - `<PROJECT>_postgres`
> - `<PROJECT>_redis`
> - 部署路径、域名、联系人信息

## 1. 快速健康检查

```bash
curl -s -o /dev/null -w "%{http_code}" http://localhost:9000/health
curl -s -o /dev/null -w "%{http_code}" http://localhost:9001/health
curl -s -o /dev/null -w "%{http_code}" http://localhost:9002/health
```

> 端口建议：9000（production）/ 9001（test）/ 9002（staging）。

## 2. 容器状态检查

```bash
docker ps -a --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
docker logs <PROJECT>_medusa --tail 100
docker logs <PROJECT>_postgres --tail 100
docker logs <PROJECT>_redis --tail 100
```

## 3. 常见应急操作

### 3.1 重启应用容器

```bash
docker restart <PROJECT>_medusa
```

### 3.2 检查 PostgreSQL

```bash
docker exec <PROJECT>_postgres pg_isready -U postgres
docker exec <PROJECT>_postgres psql -U postgres -c "SELECT now();"
```

### 3.3 检查 Redis

```bash
docker exec <PROJECT>_redis redis-cli ping
```

## 4. 升级与回滚

1. 回滚前先做数据库备份。
2. 记录回滚时间、执行人、原因。
3. 回滚后执行健康检查与关键接口验证。

## 5. 升级后验证清单

- [ ] `/health` 返回 200
- [ ] 关键 API 正常
- [ ] 数据库连接正常
- [ ] Redis 连接正常
- [ ] 错误日志无持续增长
