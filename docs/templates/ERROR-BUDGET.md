# Error Budget — {{PROJECT_NAME}}

> 版本: 1.0
> 最后更新: {{DATE}}
> 负责人: {{OWNER_NAME}}
>
> Error Budget 是 SRE 实践的核心工具：它将可靠性目标量化为"允许出错的时间"，
> 当 Budget 耗尽时自动暂停功能开发，强制优先修复稳定性问题。

---

## SLO 目标定义

### 可用性 SLO

| 服务 | SLO 目标 | 统计周期 | 计算方法 |
|------|----------|---------|---------|
| API 服务 | {{API_AVAILABILITY_SLO}} % | 滚动 30 天 | 成功请求数 / 总请求数 |
| 前端页面 | {{FRONTEND_AVAILABILITY_SLO}} % | 滚动 30 天 | Uptime 监控 |
| 数据库 | {{DB_AVAILABILITY_SLO}} % | 滚动 30 天 | 连接成功率 |

> 示例：99.9% SLO = 每月允许 43.8 分钟停机

### 延迟 SLO

| 端点类型 | P50 目标 | P95 目标 | P99 目标 |
|---------|---------|---------|---------|
| 读操作 | {{P50_READ}} ms | {{P95_READ}} ms | {{P99_READ}} ms |
| 写操作 | {{P50_WRITE}} ms | {{P95_WRITE}} ms | {{P99_WRITE}} ms |
| 后台任务 | — | {{P95_JOB}} ms | — |

### 错误率 SLO

| 服务 | 错误率上限 | 统计对象 |
|------|----------|---------|
| API 服务 | {{API_ERROR_RATE_SLO}} % | 5xx 响应 / 总请求 |
| 支付流程 | {{PAYMENT_ERROR_RATE_SLO}} % | 支付失败 / 支付尝试 |

---

## Error Budget 计算

### 公式

```
Error Budget (分钟) = 统计周期分钟数 × (1 - SLO目标)

示例（99.9% SLO，30天周期）：
  43,200 分钟 × 0.1% = 43.2 分钟
```

### 当前周期预算（滚动 30 天）

| 服务 | 总预算（分钟） | 已消耗（分钟） | 剩余（%） | 状态 |
|------|-------------|-------------|---------|------|
| API 服务 | {{TOTAL_BUDGET_API}} | {{CONSUMED_API}} | {{REMAINING_PCT_API}} | {{STATUS_API}} |
| 前端 | {{TOTAL_BUDGET_FE}} | {{CONSUMED_FE}} | {{REMAINING_PCT_FE}} | {{STATUS_FE}} |

> 此表由 `error-budget-check.yml` 工作流每日自动更新，或在 Incident 关闭后手动更新。

---

## 耗尽规则（Burn Rate Policy）

### 三级告警

| 告警级别 | 触发条件 | 响应要求 | 开发影响 |
|---------|---------|---------|---------|
| **Yellow** | 剩余 Budget < 50% | 每日监控，评估原因 | 正常开发，关注稳定性 |
| **Orange** | 剩余 Budget < 20% | Owner 通知，制定恢复计划 | 新功能开发降速 |
| **Red** | 剩余 Budget < 5% 或已耗尽 | 立即响应，所有人参与 | **功能开发暂停** |

### 耗尽时的强制规则

当 Error Budget 进入 **Red** 状态时：

1. **立即暂停**：所有新功能的 PR merge 被 `error-budget-check.yml` 物理阻断
2. **唯一例外**：带有 `type: bug-fix` 或 `type: reliability` 标签的 PR 可以继续
3. **恢复条件**：Error Budget 剩余恢复到 20% 以上，由 Owner 解封
4. **复盘要求**：每次耗尽后 48 小时内完成 Postmortem，记录到 `docs/postmortem/`

---

## 历史记录

| 周期 | 服务 | 初始预算 | 消耗量 | 耗尽？ | 主要原因 |
|------|------|---------|--------|-------|---------|
| {{PERIOD_1}} | API | {{BUDGET}} | {{CONSUMED}} | 否 | — |

---

## 监控工具配置

### Uptime Kuma（推荐自托管）

- 配置文件：`docs/UPTIME-KUMA-SETUP.md`
- 检查间隔：60 秒
- 告警渠道：{{ALERT_CHANNEL}}

### Sentry

- 项目 DSN：在 GitHub Secrets 中配置（`SENTRY_DSN`）
- 错误率告警阈值：{{SENTRY_ALERT_THRESHOLD}} 次/分钟
- Performance 监控：已启用

### 自定义指标（可选）

如需更精细的 SLO 跟踪，可集成：
- Prometheus + Grafana
- Datadog SLO Dashboard
- 配置示例见 `docs/MONITORING.md`

---

## 与 CI 的集成

`error-budget-check.yml` 工作流在每次 PR 时：

1. 读取 `docs/ERROR-BUDGET.md` 中的当前剩余预算百分比
2. 如果剩余 < 5%，自动在 PR 上添加 `error-budget-exhausted` 标签
3. 对非 bug-fix 类型的 PR 设置 CI failure，物理阻断 merge

Owner 可通过在 PR 上添加 `override-error-budget` 标签（需有仓库管理员权限）临时解除阻断，并在 PR body 中说明理由。

---

## 参考资料

- [Google SRE Book - Error Budgets](https://sre.google/sre-book/embracing-risk/)
- [SLO Academy](https://www.sloacademy.com/)
- 项目 SLA 承诺：`docs/templates/SLA.md`
