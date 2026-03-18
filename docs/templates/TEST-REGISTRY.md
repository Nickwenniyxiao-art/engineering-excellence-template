# TEST-REGISTRY.json 规范

测试注册表记录所有测试脚本与功能、Bug 的映射关系，供 AI 分析测试覆盖度和生成新测试。

## 结构

```json
{
  "version": "1.0.0",
  "last_updated": "YYYY-MM-DDTHH:mm:ssZ",
  "tests": [
    {
      "id": "T-001",
      "file": "e2e/test/smoke.spec.ts",
      "env": ["test", "staging", "production"],
      "type": "e2e | unit | integration | performance",
      "covers": {
        "feature": "F-001",
        "acceptance_criteria": ["AC-001-1"],
        "bug": null
      },
      "generated_from": "feature_list | bug_report | production_log | manual",
      "created_at": "YYYY-MM-DD",
      "last_updated": "YYYY-MM-DD",
      "description": "测试目的描述"
    }
  ]
}
```

## 触发 AI 生成新测试的场景

1. 新功能 PR merge → 生成功能测试
2. Bug Issue 关闭 → 生成回归测试
3. Sentry 新错误 → 生成边缘场景测试
4. 每周定期分析 → 补充覆盖盲区
