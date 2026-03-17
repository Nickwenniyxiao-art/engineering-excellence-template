# UPTIME-KUMA-SETUP

## 目标

使用 Uptime Kuma 搭建自托管监控，覆盖 API 可用性、网页可达性与证书有效期。

## 快速部署（Docker）

```bash
docker run -d \
  --name uptime-kuma \
  -p 3001:3001 \
  -v uptime-kuma:/app/data \
  --restart unless-stopped \
  louislam/uptime-kuma:1
```

## 建议监控项

- HTTP(s)：`/health`（9000 / 9001 / 9002）
- TCP：PostgreSQL / Redis 端口
- SSL：证书有效期
- 关键业务接口（如 `/store/products`）

## 告警建议

- 2 次连续失败触发告警
- 恢复后自动发送恢复通知
- 告警渠道：Email / Slack / Telegram（按项目实际配置）
