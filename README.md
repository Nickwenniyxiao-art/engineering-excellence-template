# 🏗️ 卓越工程治理框架 — 项目模板

> Engineering Excellence Framework Template v1.0

## 概述

这是一个**开箱即用的项目模板**，包含完整的工程治理框架体系。新项目直接使用此模板创建仓库，即可获得：

- ✅ **110 种标准文档模板**（18 个类别）
- ✅ **58+ 个自动化工作流**（CI/CD、质量门禁、安全扫描、文档检查）
- ✅ **Issue / PR 模板**（Bug、Feature、Task、Incident 等 7 种）
- ✅ **分支保护策略**（develop → staging → main 三分支）
- ✅ **安全扫描工具**（Gitleaks、Trivy、Semgrep、Dependabot）
- ✅ **DORA 度量**（部署频率、前置时间、恢复时间、失败率）
- ✅ **文档治理自动化**（DOC-LIBRARY + DOC-REGISTRY 自动同步）

---

## 🚀 快速开始（3 步上手）

### Step 1: 从模板创建新仓库

点击页面右上角的 **"Use this template"** → **"Create a new repository"**

### Step 2: 激活工作流

模板仓库的工作流按 **前端/后端/通用** 分类存放：

```
.github/workflows/
├── shared/       ← 通用工作流（PR检查、安全扫描等） — 直接使用
├── backend/      ← 后端专用（CI、CD、DB备份等）
└── frontend/     ← 前端专用（CI、CD、Lighthouse等）
```

**根据你的项目类型，将对应目录下的 `.yml` 文件移动到 `.github/workflows/` 根目录：**

```bash
# 后端项目
cp .github/workflows/shared/*.yml .github/workflows/
cp .github/workflows/backend/*.yml .github/workflows/

# 前端项目
cp .github/workflows/shared/*.yml .github/workflows/
cp .github/workflows/frontend/*.yml .github/workflows/

# 全栈项目：全部复制
cp .github/workflows/shared/*.yml .github/workflows/
cp .github/workflows/backend/*.yml .github/workflows/
cp .github/workflows/frontend/*.yml .github/workflows/
```

激活后可以删除 `shared/`、`backend/`、`frontend/` 子目录。

### Step 3: 配置项目

1. **替换占位符**：全局搜索 `YOUR-` 并替换
   - `YOUR-GITHUB-USERNAME` → 你的 GitHub 用户名
   - `YOUR-PROJECT-NAME` → 项目名称
   - `YOUR-SECURITY-EMAIL` → 安全联系邮箱

2. **设置 Secrets**（Settings → Secrets → Actions）：
   - `CD_PAT` — 具有 repo 权限的 Personal Access Token
   - `DEPLOY_SSH_KEY` — 部署服务器的 SSH 私钥
   - `DEPLOY_HOST` — 服务器 IP
   - `DEPLOY_USER` — 服务器用户名

3. **创建分支**：
   ```bash
   git checkout -b staging
   git push origin staging
   git checkout -b develop
   git push origin develop
   ```

4. **设置分支保护**（Settings → Branches）：
   - `develop`: Require PR + 1 approval + status checks
   - `staging`: Require build check
   - `main`: Require PR + 1 approval

---

## 📁 目录结构

```
.
├── .github/
│   ├── CODEOWNERS                    # 代码审核责任人
│   ├── PULL_REQUEST_TEMPLATE.md      # PR 模板
│   ├── dependabot.yml                # 依赖自动更新
│   ├── ISSUE_TEMPLATE/               # Issue 模板（7种）
│   │   ├── bug.yml                   #   Bug 报告
│   │   ├── feature.yml               #   Feature 请求
│   │   ├── task.yml                  #   任务
│   │   ├── incident.yml              #   事故
│   │   ├── incident-postmortem.yml   #   事故复盘
│   │   ├── research.yml              #   研究
│   │   └── config.yml                #   模板配置
│   └── workflows/
│       ├── shared/                   # 通用工作流（29个）
│       ├── backend/                  # 后端工作流（20个）
│       └── frontend/                 # 前端工作流（9个）
│
├── docs/
│   ├── standards/
│   │   └── DOC-LIBRARY.json          # 文档类型库（18类110种）
│   ├── templates/                    # 所有文档模板（112个）
│   │   ├── 01-initiation/            #   项目启动
│   │   ├── 02-requirements/          #   需求管理
│   │   ├── ...                       #   （18个类别目录）
│   │   └── ADR/                      #   架构决策记录
│   ├── TASK-REGISTRY.json            # 任务注册表
│   └── schemas/                      # JSON Schema
│
├── scripts/
│   └── sync-registry.js              # Registry 自动同步脚本
│
├── DOC-REGISTRY.json                 # 文档注册表（根目录）
├── AGENTS.md                         # AI 协作指南（需定制）
├── SECURITY.md                       # 安全策略
├── .env.example                      # 环境变量模板
├── .gitignore                        # Git 忽略规则
├── .gitleaks.toml                    # Gitleaks 配置
├── .markdownlint.yml                 # Markdown 规范
├── .prettierrc                       # Prettier 配置
├── .releaserc.json                   # semantic-release 配置
├── commitlint.config.mjs             # Commitlint 配置
└── README.md                         # 本文件
```

---

## 📋 新项目 7 天搭建清单

| Phase | 时间 | 任务 |
|-------|------|------|
| **Phase 0** | 第 1 天 | 创建仓库 → 三分支 → 分支保护 → Project Board → Secrets |
| **Phase 1** | 第 1-2 天 | 激活 CI/CD 工作流 → Docker → Smoke Test → Release |
| **Phase 2** | 第 2-3 天 | 激活 PR 检查 → Required Checks → AI Review → Commitlint |
| **Phase 3** | 第 3-5 天 | 定制 DOC-LIBRARY → 初始化 Registry → 创建 Gate 1 文档 |
| **Phase 4** | 第 5-7 天 | 安全扫描 → DB 备份 → 监控 → Runbook |

---

## 📖 文档治理体系

### 18 个文档类别

| # | 类别 | 文档数 | 必选 |
|---|------|--------|------|
| 01 | 项目启动 (initiation) | 5 | ✅ |
| 02 | 需求管理 (requirements) | 6 | ✅ |
| 03 | 系统设计 (design) | 7 | ✅ |
| 04 | 开发规范 (development) | 8 | ✅ |
| 05 | 测试管理 (testing) | 5 | ✅ |
| 06 | 部署发布 (deployment) | 5 | ✅ |
| 07 | 运维管理 (operations) | 7 | ✅ |
| 08 | 合规安全 (compliance) | 5 | ✅ |
| 09 | 项目治理 (governance) | 2 | ✅ |
| 10 | AI/ML | 10 | 按需 |
| 11 | 物联网 (iot) | 8 | 按需 |
| 12 | 微服务 (microservice) | 8 | 按需 |
| 13 | SaaS | 8 | 按需 |
| 14 | 移动端 (mobile) | 8 | 按需 |
| 15 | 嵌入式 (embedded) | 6 | 按需 |
| 16 | 数据平台 (data-platform) | 6 | 按需 |
| 17 | 高级安全 (security-advanced) | 3 | 按需 |
| 18 | 金融科技 (fintech) | 3 | 按需 |

### 阶段门禁 (Gate)

| Gate | 阶段 | 说明 |
|------|------|------|
| Gate 1 | 启动 | 项目启动前必须完成 |
| Gate 2 | 开发 | 进入开发阶段前完成 |
| Gate 3 | 部署 | 部署上线前完成 |
| Gate 4 | 治理 | 持续治理阶段 |

---

## 🔒 铁律 (Iron Rules)

1. **R1**: CTO/技术负责人不直接写代码，通过 Issue + AI 任务驱动
2. **R2**: 所有变更必须走 CI/CD 流水线
3. **R3**: staging 不需审批，production 需 Owner 审批
4. **R4**: 先出方案，再执行
5. **R5**: 格式问题由 autofix 解决
6. **R6**: 沟通使用团队语言
7. **R7**: 独立调查，不打扰 Owner

---

## 📊 评估标准

| 维度 | 满分 | 评估内容 |
|------|------|----------|
| 文档完整度 | 20 | DOC-REGISTRY exists 比例 |
| CI/CD 覆盖度 | 20 | 工作流完整性 |
| 质量门禁覆盖度 | 20 | PR checks 数量 |
| 安全扫描覆盖度 | 20 | 安全工具配置 |
| 运维自动化程度 | 20 | 备份/监控/应急 |

**等级**: 卓越 (90-100) | 优秀 (75-89) | 达标 (60-74) | 不达标 (<60)

---

## License

MIT
