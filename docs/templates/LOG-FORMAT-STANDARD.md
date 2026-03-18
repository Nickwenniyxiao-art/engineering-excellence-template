# 日志格式标准

AI 测试生成系统依赖结构化日志。所有日志必须遵循以下格式。

## 结构化日志字段（必须）

```json
{
  "timestamp": "2026-03-18T10:00:00.000Z",
  "level": "error | warn | info | debug",
  "service": "frontend | backend | worker",
  "module": "cart | checkout | auth | ...",
  "traceId": "uuid",
  "message": "Human readable message",
  "error": {
    "type": "ErrorType",
    "message": "Error message",
    "stack": "..."
  },
  "context": {
    "userId": "...",
    "requestId": "...",
    "endpoint": "..."
  }
}
```

## 日志层级

| Layer | 来源 | 用途 |
|-------|------|------|
| 应用日志 | Sentry + 结构化日志 | 错误追踪、AI 生成测试 |
| 测试日志 | Playwright HTML 报告 | 失败分析、测试优化 |
| 部署日志 | DEPLOY-LOG.md | 变更追踪 |
| 告警日志 | Telegram + GitHub Issues | 事故响应 |
| Bug 日志 | GitHub Issues (type:bug) | 回归测试生成 |

## AI 读取日志的优先级

1. Sentry 错误 → 立即生成边缘场景测试
2. Bug Issue 关闭 → 生成回归测试（48小时内）
3. 测试失败报告 → 分析根因 + 优化测试
4. 每周部署日志 → 分析趋势 + 补充测试覆盖
