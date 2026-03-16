# AGENTS.md — [项目名称]

## Project Overview

[项目描述 — 请替换为你的项目说明]

## Tech Stack

- Runtime: [例如 Node.js 20+]
- Framework: [例如 Medusa.js v2 / Next.js 15]
- Language: TypeScript 5.6+
- Database: [例如 PostgreSQL]
- Containerization: Docker

## Project Structure

```
src/
├── api/          # API 路由
├── modules/      # 功能模块
├── services/     # 业务服务
├── utils/        # 工具函数
└── types/        # 类型定义
```

## Key Conventions

- All source code in `src/` uses TypeScript
- Environment variables defined in `.env` (see `.env.example`)
- Commits follow Conventional Commits specification

## Branch Strategy

- `develop` → `staging` → `main`
- Feature branches: `feature/xxx`, `fix/xxx`, `chore/xxx`
- All PRs target `develop` branch

## CI/CD Pipeline

- CI: build + lint + typecheck + test (on PR)
- CD-Test: deploy to test env (on merge to develop)
- CD-Staging: deploy to staging (on merge to staging)
- CD-Production: deploy to production (on merge to main, requires approval)

## Iron Rules

1. CTO/技术负责人不直接写代码，通过 Issue + AI 任务驱动
2. 所有变更必须走 CI/CD 流水线
3. staging 不需审批，production 需 Owner 审批
4. 先出方案，再执行
5. 格式问题由 autofix 解决
6. 沟通使用团队语言
7. 独立调查，不打扰 Owner
