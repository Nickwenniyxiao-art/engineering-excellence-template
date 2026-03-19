# AGENTS.md — AI Agent 使用指南

> 本文件是 AI Agent 在此框架下工作的完整操作手册。
> 新项目请在此文件顶部填写项目上下文，保留以下所有章节。

---

## 项目上下文（新项目必填）

| 字段 | 值 |
|------|-----|
| 项目名称 | [项目名称] |
| 技术栈 | [Runtime / Framework / Database] |
| 当前阶段 | [Phase 0 / 1 / 2 / 3 / 4] |
| Owner | [Owner 姓名/联系方式] |
| 仓库分支策略 | develop → staging → main |

**详细上下文**：见 `docs/AI-CONTEXT.md`（每个 Phase 开始时更新）

---

## 铁律（Iron Rules）——AI 必须无条件遵守

1. **R1 文档先行**：任何功能的第一行代码必须在对应文档齐全且经 Owner approve 之后才能写。CI 会物理拒绝无对应文档的 PR。
2. **R2 范围控制**：只实现 `docs/FEATURE-LIST.md` 中状态为 `approved` 的功能。任何超范围改动必须先走变更流程。
3. **R3 变更管理**：已批准的设计如需变更，必须先创建 CHANGE-REQUEST Issue（含影响评估），等 Owner approve 后，才能修改文档，文档 merge 后才能动代码。严禁跳步。
4. **R4 提问优先**：遇到任何不确定的需求，先走 AI 提问协议，不要自行假设。
5. **R5 Owner 节点**：以下操作必须停下来等待 Owner 明确 approve，不得自行推进：
   - 新功能进入开发阶段（Phase 转换）
   - 已批准方案的重大设计变更
   - RFC 提案定稿
   - Production 部署
6. **R6 独立调查**：不要因为遇到问题就频繁打扰 Owner。先查文档、查日志、查 Issue，调查清楚后再汇报。
7. **R7 可追溯性**：所有重要技术决策记录到 `docs/AI-DECISION-LOG.md`，所有任务通过 GitHub Issues 跟踪。

---

## 如何启动一个新项目（Phase 顺序操作）

### Phase 0：立项（目标：明确做什么）

**AI 操作步骤**：

1. 读取此 AGENTS.md 和 `docs/AI-CONTEXT.md`（如果存在）
2. 创建一个 GitHub Issue，标签 `phase:initiation`，触发 AI 提问协议
3. 根据 Owner 回答，生成以下文档（PR 提交，等待 Owner approve）：
   - `docs/PROJECT-SCOPE.md`
   - `docs/STAKEHOLDER-REGISTER.md`（如需要）
   - `docs/FEASIBILITY-STUDY.md`（如需要）
4. 更新 `docs/AI-CONTEXT.md` 中的项目基本信息
5. **等待 Owner approve 文档 PR → Phase 0 完成**

**门禁**：Phase 0 文档 PR 未 merge，不得进入 Phase 1。

---

### Phase 1：需求（目标：明确功能清单）

**AI 操作步骤**：

1. 创建 GitHub Issue，标签 `phase:requirements`，触发需求提问
2. 根据 Owner 回答，生成文档（PR 提交，等待 approve）：
   - `docs/PRD.md` — 产品需求文档
   - `docs/FEATURE-LIST.md` — **功能清单（CI 范围校验的基础）**
   - `docs/USER-STORIES.md`
   - `docs/ACCEPTANCE-CRITERIA.md`
3. 在 `docs/TASK-REGISTRY.json` 中为每个 P0 功能创建条目
4. **等待 Owner approve 文档 PR → Phase 1 完成**

**FEATURE-LIST 格式要求**：

```markdown
## [模块名]

- **状态**: approved
- **优先级**: P0
- **描述**: [功能描述]
- **验收标准**: [验收标准]
```

**门禁**：`docs/FEATURE-LIST.md` 不存在或无 `approved` 条目，CI 的 `check-scope.yml` 会拒绝所有代码 PR。

---

### Phase 2：设计（目标：明确怎么做）

**AI 操作步骤**：

1. 创建 GitHub Issue，标签 `phase:design`，触发设计提问
2. 根据 Owner 回答和 FEATURE-LIST，生成设计文档：
   - `docs/ARCHITECTURE.md`
   - `docs/DATABASE-SCHEMA.md`（如需要）
   - `docs/API-REFERENCE.md`（如需要）
   - `docs/ADR/ADR-001.md`（首批架构决策）
3. 对于重大技术决策（技术栈选型、核心架构模式）：
   - 在 `docs/AI-DECISION-LOG.md` 记录决策，等待 Owner 确认
   - 如果决策影响范围大，创建 RFC 文档（`docs/RFC-001.md`），走 RFC 评审流程
4. 设计文档 PR 需要 Owner approve
5. **等待 Owner approve → Phase 2 完成，可进入开发**

**门禁**：进入 Phase 3 前，必须有 ARCHITECTURE.md 且至少一条 ADR 记录。

---

### Phase 3：开发（目标：写代码）

**每个功能模块的开发流程**：

```
创建 Feature Issue（带 approved 标签）
        ↓
AI 创建功能分支（feature/xxx）
        ↓
写代码 + 写测试（覆盖率 ≥ 阈值）
        ↓
提交 PR，Closes #issue_number
        ↓
CI 自动检查（约 5 分钟）：
  - check-scope（模块在 FEATURE-LIST？）
  - check-module-docs（文档存在？）
  - check-test-coverage（覆盖率达标？）
  - pr-compliance-gate（Issue approved？）
        ↓
Owner Code Review（可选，重要功能必须）
        ↓
Merge to develop
        ↓
自动部署到 Test 环境
```

**开发注意事项**：

- 每个 PR 只做一件事，对应一个 Issue
- Commit message 遵循 Conventional Commits：`feat(module): description`
- 禁止一个 PR 同时修改多个不相关模块
- Bug 修复 PR 必须包含回归测试（`check-test-coverage.yml` 强制）
- 任何发现的需求变化，必须停下来走变更流程，不要偷偷改

---

### Phase 4：发布（目标：安全上线）

**发布流程**：

```
develop → staging（自动，CD-Staging）
        ↓
Staging 环境验证（Smoke Test + E2E）
        ↓
完成 PRR 检查单（docs/PRR.md）
        ↓
创建 promote PR（staging → main）
        ↓
prr-gate.yml 自动检查
        ↓
Owner approve promote PR
        ↓
自动部署 Production
```

**PRR 检查单完成标准**：所有 checkbox 勾选，无未解决的 Known Issues。

---

## 每个 Phase 的文档要求和 CI 门禁

| Phase | 必须存在的文档 | CI 检查 |
|-------|-------------|---------|
| 进入 Phase 1 前 | PROJECT-SCOPE.md | doc-gate-check.yml |
| 进入 Phase 2 前 | FEATURE-LIST.md, PRD.md | doc-gate-check.yml |
| 进入 Phase 3 前 | ARCHITECTURE.md, ADR 至少 1 条 | doc-gate-check.yml |
| 每个代码 PR | 对应模块文档 | check-module-docs.yml |
| Bug 修复 PR | 回归测试文件 | check-test-coverage.yml |
| Production 发布 | PRR.md 全部勾选 | prr-gate.yml |

---

## 如何处理变更申请

当 Owner 或 AI 发现需要变更已批准的功能/设计时：

### 步骤 1：创建变更申请

在 GitHub 创建 Issue，类型选 `type:change-request`（会触发 AI 提问协议）。

### 步骤 2：完成影响评估

根据提问协议的回答，更新 `docs/CHANGE-REQUEST.md`，包含：
- 变更内容描述
- 受影响的模块列表
- 受影响的文档列表
- 工作量和时间影响评估
- 备选方案

### 步骤 3：等待 Owner approve

`check-change-request.yml` 会阻断所有引用此变更的代码 PR，直到 Issue 获得 `approved` 标签。

### 步骤 4：文档先行

Owner approve 后，先提交文档更新 PR（更新 FEATURE-LIST、PRD、模块文档等），等文档 merge 后才提交代码 PR。

### 步骤 5：代码实现

代码 PR 的 body 中引用 `Change Request: #<issue_number>`，通过 CI 检查后 merge。

---

## CI 失败时的处理流程

### 1. 先读失败信息

CI 失败时，先完整读取 GitHub Actions 的 failure log，理解是哪个步骤失败，为什么失败。

### 2. 常见失败类型和对应处理

| CI 检查 | 失败原因 | 处理方式 |
|---------|---------|---------|
| `check-scope` | 模块不在 FEATURE-LIST | 先走变更流程，更新 FEATURE-LIST |
| `check-module-docs` | 缺少模块文档 | 创建/更新模块文档 |
| `check-test-coverage` | 覆盖率不足或缺少测试 | 补充测试，特别是 Bug 修复必须有回归测试 |
| `check-change-request` | 变更 PR 未引用 approved Issue | 创建并等待批准变更 Issue，或在 PR body 引用 |
| `pr-compliance-gate` | Issue 未 approved | 等 Owner 给 Issue 加 approved 标签 |
| `doc-gate-check` | 必要文档缺失 | 创建缺失文档并走 PR |
| `prr-gate` | PRR 检查单未完成 | 完成 PRR 所有检查项 |
| `error-budget-check` | Error Budget 耗尽 | 暂停功能开发，优先修复稳定性问题 |
| `rfc-review` | RFC 格式不完整或未 approved | 补全 RFC 文档或等待 RFC 评审通过 |
| `commitlint` | Commit message 格式错误 | 修改 commit message，遵循 Conventional Commits |
| `actionlint` | Workflow 语法错误 | 修复 YAML 语法 |

### 3. 不要绕过 CI

**禁止**：添加 `--no-verify` 跳过 Git hooks，或强制 push 绕过分支保护。

**允许的豁免标签**（需要 Owner 显式添加）：
- `no-issue` — 基础设施变更，跳过 Issue 关联检查
- `hotfix` — 紧急热修复，跳过部分检查
- `egp-bootstrap` — 框架初始化，跳过范围检查
- `override-error-budget` — Error Budget 耗尽时 Owner 临时解除阻断

---

## 测试生成规则

### 何时触发测试生成

AI 应在以下情况主动生成或更新测试：

| 触发事件 | 生成内容 | 更新位置 |
|---------|---------|---------|
| 新功能 PR merge | 单元测试 + 集成测试 | `src/tests/` 对应模块 |
| Bug Issue 关闭 | 回归测试（防止复现） | `src/tests/regression/` |
| E2E 测试失败 | 修复 + 记录失败场景 | `src/tests/e2e/` |
| Sentry 新错误 | 对应错误场景的单元测试 | `src/tests/` |
| 每周定期扫描 | 检查 FEATURE-LIST 中无测试的功能 | 补充缺失测试 |

### 测试注册表维护

每个测试生成后，更新 `docs/TEST-REGISTRY.json`：

```json
{
  "test_id": "T-001",
  "type": "unit",
  "target_feature": "FEAT-001",
  "file": "src/tests/cart/add-item.test.ts",
  "trigger": "feature-merge",
  "created_at": "2026-03-01",
  "last_run": "2026-03-18",
  "status": "passing"
}
```

### 测试命名规范

```
[模块名]-[功能]-[场景].test.ts
例：cart-add-item-success.test.ts
    cart-add-item-out-of-stock.test.ts
    auth-login-invalid-password.test.ts
```

---

## 日志与可观测性规范

所有日志必须遵循 `docs/templates/LOG-FORMAT-STANDARD.md` 中的结构化格式：

```typescript
// 推荐格式
logger.info('order.created', {
  orderId: order.id,
  userId: user.id,
  amount: order.total,
  duration_ms: elapsed,
  trace_id: ctx.traceId
});
```

- 不使用 `console.log`，使用结构化日志库
- 每个重要业务操作必须有对应的 log 事件
- Error 日志必须包含 `trace_id` 和足够的上下文
- AI 从日志中提取测试场景时依赖结构化格式

---

## RFC 评审流程

当遇到以下情况时，必须先完成 RFC 评审才能写代码：

- 影响多个模块的架构变更
- 引入新的核心依赖（数据库、消息队列、缓存方案）
- 重大 API 设计变更（Breaking Change）
- 性能架构重设计

**RFC 流程**：

1. 创建 `docs/RFC-NNN.md`（使用 `docs/templates/RFC.md` 模板）
2. 提交 PR，添加标签 `type:rfc`
3. `rfc-review.yml` 自动验证格式完整性并发布评审 Checklist
4. Owner 在 PR 上 Approve → RFC 状态改为 `Approved`
5. 代码实现 PR 中引用 `Implements RFC-NNN`

---

## 常用命令参考

```bash
# 查看当前 CI 状态
gh pr checks <PR_NUMBER>

# 查看 CI 失败详情
gh run view <RUN_ID> --log-failed

# 查看当前 Issue 列表
gh issue list --label approved

# 创建变更申请 Issue
gh issue create --label type:change-request --title "CR: [变更描述]"

# 查看 Error Budget 状态
cat docs/ERROR-BUDGET.md | grep -A5 "当前周期预算"

# 检查 FEATURE-LIST 模块状态
grep -A3 "状态" docs/FEATURE-LIST.md
```

---

## AI 操作治理协议（所有 AI 必须严格遵守）

> 本章节是框架的执行纪律核心。任何 AI 接手项目，必须将本章节规则内化为默认行为。

### 核心原则：无 Issue，不执行

```
任何有副作用的操作 = 必须有 GitHub Issue + Owner 明确授权
```

**"Owner 描述了一个问题"** ≠ 授权执行
**"CTO/PM 说立即做"** ≠ 授权 AI 执行
**"紧急情况"** ≠ 可以绕过流程

### 变更分类与对应流程

| 变更类型 | 标准流程 | 最小要求 |
|---------|---------|---------|
| 代码变更 | Issue → PR → CI → Owner approve → merge | Issue + PR |
| 基础设施变更 | Issue → PR → CI → Owner approve → merge → workflow 部署 | Issue + PR + workflow |
| 配置变更（.env、crontab）| 同基础设施变更 | Issue + PR + workflow |
| 只读排查（SSH 查看日志）| 口头说明即可 | 告知 Owner 要查什么 |
| 紧急生产故障 | 告知 → Owner 说可以 → 执行 → 立即记录 | 24h 内补 Issue |

### 有副作用的操作（执行前必须有 Issue + 授权）

- SSH 写操作：写文件、改 crontab、重启容器、修改配置
- Git 操作：commit、push、merge
- GitHub 操作：创建/关闭 Issue 和 PR、修改 label
- 服务器部署：docker pull/up、rsync、scp
- 数据库：任何写操作或 migration
- 外部 API：Telegram、第三方服务调用

### AI 执行前的标准话术

```
我准备执行以下操作，关联 Issue #XXX：
1. [操作1]
2. [操作2]

等待你的授权（回复"可以"）。
```

### VPS 操作铁律

```
❌ 绝对禁止：AI 直接 SSH 写操作（无论何种理由）
✅ 唯一允许：通过 GitHub Actions workflow 执行部署
✅ 只读例外：SSH 查看日志、磁盘、进程（必须告知 Owner）
```

### ai-decision Issue 规范

每次重要执行后，AI 必须创建 GitHub Issue：

```markdown
标题：[AI-DECISION] YYYY-MM-DD 操作简述
Label：ai-decision
内容：
- 操作详情（做了什么）
- 授权依据（Owner 原话/时间）
- 执行结果
- 遗留事项
```

### 如何查看所有 AI 决策记录

```bash
# 查看所有 AI 决策 Issue
gh issue list --label ai-decision --state all

# 查看最近 AI 操作
gh issue list --label ai-decision --limit 10
```

或在 GitHub 仓库页面：Issues → Label → `ai-decision`

### 禁止行为（违反即为框架违规）

- ❌ 看到"立即做"就直接执行 SSH 操作
- ❌ 以"紧急"为由跳过 Issue 和 PR
- ❌ 先执行，后告知 Owner
- ❌ 执行后不创建 ai-decision Issue
- ❌ 把意图描述当作执行授权
- ❌ 直接 push 到 main/staging/develop（受保护分支）

### 违规处理

若 AI 发现自己已经违规执行：

1. **立即停止**进一步操作
2. **告知 Owner** 已执行了什么
3. **等待 Owner 决定**是否回滚
4. **无论是否回滚**，必须补开 ai-decision Issue 记录
5. 在 Issue 中标注"违规操作，事后补录"

---

## 可观测性：如何查看项目执行状态

### AI 决策审计
```bash
gh issue list --label ai-decision --state all --repo <owner>/<repo>
```

### 部署历史
```bash
gh run list --workflow=cd-production.yml
gh run list --workflow=deploy-ops-scripts.yml
```

### 当前 PR 状态
```bash
gh pr list --state open
gh pr checks <PR_NUMBER>
```

### 服务器状态（只读）
```bash
# 磁盘
ssh root@<VPS_IP> "df -h /"
# 容器
ssh root@<VPS_IP> "docker ps --format 'table {{.Names}}\t{{.Status}}'"
# 最近日志
ssh root@<VPS_IP> "docker logs --tail=50 <container>"
```
