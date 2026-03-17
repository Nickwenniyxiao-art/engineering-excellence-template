# TESTING-STRATEGY

> 版本：v4.0（四支柱补强）

## 目标

- 建立可落地、可迭代的测试基线。
- 支持 CI 中 lint/typecheck/test 的统一门禁。
- 为新项目提供可直接复用的 Jest 配置与示例用例。

## 测试分层

1. **Unit Test（70%）**：聚焦纯函数与业务规则。
2. **Integration Test（20%）**：聚焦模块协作、数据库与外部依赖的集成行为。
3. **E2E Test（10%）**：覆盖关键用户路径与回归风险点。

## 目录与命名

- Jest 配置：`jest.config.ts`
- 示例测试：`src/__tests__/example.unit.test.ts`
- 文件命名：`*.test.ts` / `*.spec.ts`

## CI 建议

- PR：`lint + typecheck + unit test`
- Nightly：`full test suite + coverage report`

## 覆盖率建议（初始）

- 语句（statements）≥ 60%
- 分支（branches）≥ 50%
- 函数（functions）≥ 60%
- 行（lines）≥ 60%

## 维护规则

- 每个 bugfix 必须附带回归测试。
- 每次功能变更同步更新测试。
- Flaky test 统一记录并在一个迭代内修复。
