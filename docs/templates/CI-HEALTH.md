---
项目名称: <项目名>
创建日期: <YYYY-MM-DD>
状态: <草稿|审核中|已发布|已归档>
负责人: <角色/姓名>
关联文档: ENGINEERING-PLAYBOOK.md 第14章
---

# CI/CD 工作流健康度标准

## 概述
本文档定义所有 GitHub Actions 工作流的分级、预期状态和监控标准。

## 工作流分级标准

| 级别 | 定义 | 失败影响 | SLA |
|------|------|---------|-----|
| **Critical** | CI/CD 核心流程 | 阻塞合并或部署 | 24h |
| **Standard** | 质量与安全检查 | 需记录但不阻塞 | 72h |
| **Advisory** | 建议性辅助检查 | 仅通知 | 下个Sprint |

## 工作流清单

### Critical（必须绿）

| 工作流文件 | 名称 | 触发条件 | 预期状态 |
|-----------|------|---------|---------|
| ci.yml | CI | push/PR | ✅ 必须绿 |
| cd-test.yml | CD — Test | push develop | ✅ 必须绿 |
| cd-staging.yml | CD — Staging | push staging | ✅ 必须绿 |
| cd-production.yml | CD — Production | push main | ✅ 必须绿 |
| release.yml | Release | push main | ✅ 必须绿 |
| db-backup.yml | Database Backup | cron daily | ✅ 必须绿 |

### Standard（应该绿）

> 请根据项目实际情况填写

### Advisory（可以暂时不绿）

> 请根据项目实际情况填写

## 绿率目标
- Critical: 100%
- Standard: > 90%
- Advisory: > 70%
- 总体目标: > 95%

## 红叉处理流程
1. Critical 工作流失败 → 24小时内必须修复或临时禁用
2. Standard 工作流失败 → 创建 Issue 记录，72小时内处理
3. Advisory 工作流失败 → 记入 Sprint backlog
