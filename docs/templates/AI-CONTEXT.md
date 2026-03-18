# AI 上下文包 — {{PROJECT_NAME}}

> AI Agent 启动时必读。本文档是该项目的完整上下文摘要，让 AI 在无需翻阅所有文档的情况下快速定位当前状态。
> 更新频率：每个 Phase 开始时更新，重大决策后立即更新。

---

## 项目基本信息

| 字段 | 值 |
|------|-----|
| 项目名称 | {{PROJECT_NAME}} |
| 项目类型 | {{PROJECT_TYPE}} （例：SaaS / 移动端 / 后端服务 / 全栈） |
| 当前阶段 | {{CURRENT_PHASE}} （Phase 0 / 1 / 2 / 3 / 4） |
| Owner | {{OWNER_NAME}} |
| 技术栈 | {{TECH_STACK}} |
| 仓库地址 | {{REPO_URL}} |
| 创建日期 | {{CREATED_DATE}} |

---

## 技术栈详情

```
Runtime:     {{RUNTIME}}
Framework:   {{FRAMEWORK}}
Language:    {{LANGUAGE}}
Database:    {{DATABASE}}
Cache:       {{CACHE}}
Message Queue: {{MESSAGE_QUEUE}}
Hosting:     {{HOSTING}}
CDN:         {{CDN}}
```

---

## 分支策略

| 分支 | 用途 | 部署环境 | 需要审批 |
|------|------|----------|---------|
| `develop` | 日常开发集成 | Test | 否 |
| `staging` | 预发布验证 | Staging | 否 |
| `main` | 生产发布 | Production | **是（Owner）** |

当前活跃分支策略：{{BRANCH_STRATEGY}}

---

## 项目目标与成功标准

**核心目标**：{{PROJECT_GOAL}}

**目标用户**：{{TARGET_USERS}}

**成功标准**：
- {{SUCCESS_CRITERION_1}}
- {{SUCCESS_CRITERION_2}}
- {{SUCCESS_CRITERION_3}}

---

## 当前阶段状态（{{CURRENT_PHASE}}）

**阶段目标**：{{PHASE_GOAL}}

**已完成**：
- {{COMPLETED_ITEM_1}}
- {{COMPLETED_ITEM_2}}

**进行中**：
- {{IN_PROGRESS_ITEM}}

**待办**：
- {{TODO_ITEM_1}}
- {{TODO_ITEM_2}}

**下一个 Owner Approve 节点**：{{NEXT_APPROVAL_POINT}}

---

## 核心模块清单

> 来源：docs/FEATURE-LIST.md（以该文件为准）

| 模块 | 状态 | 优先级 | 负责 AI |
|------|------|--------|---------|
| {{MODULE_1}} | approved / in-progress / pending | P0 | {{AI_AGENT}} |
| {{MODULE_2}} | approved | P1 | {{AI_AGENT}} |

---

## 关键文档索引

| 文档 | 路径 | 最后更新 |
|------|------|---------|
| 项目范围 | docs/PROJECT-SCOPE.md | {{DATE}} |
| 功能清单 | docs/FEATURE-LIST.md | {{DATE}} |
| 架构设计 | docs/ARCHITECTURE.md | {{DATE}} |
| API 文档 | docs/API-REFERENCE.md | {{DATE}} |
| Runbook | docs/RUNBOOK.md | {{DATE}} |
| 测试注册表 | docs/TEST-REGISTRY.json | {{DATE}} |
| 任务注册表 | docs/TASK-REGISTRY.json | {{DATE}} |

---

## 重要决策记录

> AI 做过的关键技术决策摘要。完整记录见 docs/AI-DECISION-LOG.md

| 日期 | 决策 | 结论 |
|------|------|------|
| {{DATE}} | {{DECISION_SUMMARY}} | {{CONCLUSION}} |

---

## AI 行为规则（本项目特定）

1. **提问优先**：遇到任何不确定的需求，先走 AI 提问协议（AI-INTERVIEW-PROTOCOL.md），不要自行假设
2. **文档先行**：任何新功能开发前，必须完成对应的功能文档，CI 会物理拒绝无文档的 PR
3. **范围控制**：只实现 FEATURE-LIST 中 `approved` 状态的功能，新增功能必须先更新 FEATURE-LIST 并等待 Owner 批准
4. **变更管理**：已批准的设计如需变更，必须先创建 CHANGE-REQUEST 并等待 Owner 批准，严禁直接修改代码
5. **Owner 节点**：以下操作必须等待 Owner 明确 approve：
   - 新功能进入开发阶段
   - 已批准方案的重大设计变更
   - Production 部署
   - RFC 提案定稿

---

## SLO 目标（生产环境）

| 指标 | 目标 | 当前 Error Budget |
|------|------|-----------------|
| 可用性 | {{AVAILABILITY_SLO}} | {{ERROR_BUDGET_REMAINING}} |
| P95 延迟 | {{LATENCY_P95_SLO}} | — |
| 错误率 | {{ERROR_RATE_SLO}} | — |

> Error Budget 耗尽规则：详见 docs/ERROR-BUDGET.md

---

## 紧急联系

- **Owner Slack/微信**: {{OWNER_CONTACT}}
- **Production 告警**: {{ALERT_CHANNEL}}
- **On-call Runbook**: docs/RUNBOOK.md

---

## 更新日志

| 日期 | 更新人 | 变更内容 |
|------|--------|---------|
| {{DATE}} | AI | 初始创建 |
