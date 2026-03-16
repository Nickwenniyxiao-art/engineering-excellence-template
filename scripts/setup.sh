#!/bin/bash
# ============================================
# 卓越工程框架 — 项目初始化脚本
# Engineering Excellence Framework Setup
# ============================================
# 用法: ./scripts/setup.sh [backend|frontend|fullstack]
# ============================================

set -e

TYPE=${1:-"backend"}
echo "🏗️  卓越工程框架 — 项目初始化"
echo "================================"
echo "项目类型: $TYPE"
echo ""

# Step 1: Move workflows
echo "📦 Step 1: 激活工作流..."

# Always copy shared workflows
cp .github/workflows/shared/*.yml .github/workflows/ 2>/dev/null || true

case "$TYPE" in
  backend)
    cp .github/workflows/backend/*.yml .github/workflows/ 2>/dev/null || true
    echo "  ✅ 共享工作流 + 后端工作流已激活"
    ;;
  frontend)
    cp .github/workflows/frontend/*.yml .github/workflows/ 2>/dev/null || true
    echo "  ✅ 共享工作流 + 前端工作流已激活"
    ;;
  fullstack)
    cp .github/workflows/backend/*.yml .github/workflows/ 2>/dev/null || true
    cp .github/workflows/frontend/*.yml .github/workflows/ 2>/dev/null || true
    echo "  ✅ 所有工作流已激活"
    ;;
  *)
    echo "❌ 未知项目类型: $TYPE"
    echo "用法: ./scripts/setup.sh [backend|frontend|fullstack]"
    exit 1
    ;;
esac

# Clean up subdirectories
rm -rf .github/workflows/shared .github/workflows/backend .github/workflows/frontend
echo "  🧹 已清理工作流子目录"

# Step 2: Initialize DOC-REGISTRY
echo ""
echo "📝 Step 2: 初始化文档注册表..."
# DOC-REGISTRY.json already exists at root, just confirm
if [ -f "DOC-REGISTRY.json" ]; then
  echo "  ✅ DOC-REGISTRY.json 已就绪"
else
  echo "  ⚠️  DOC-REGISTRY.json 不存在，请手动创建"
fi

# Step 3: Remind about configuration
echo ""
echo "⚙️  Step 3: 请手动完成以下配置："
echo ""
echo "  1. 替换 CODEOWNERS 中的 @YOUR-GITHUB-USERNAME"
echo "  2. 替换 SECURITY.md 中的 [YOUR-SECURITY-EMAIL]"
echo "  3. 编辑 AGENTS.md 填入项目信息"
echo "  4. 设置 GitHub Secrets (CD_PAT, DEPLOY_SSH_KEY 等)"
echo "  5. 创建 develop 和 staging 分支"
echo "  6. 配置分支保护规则"
echo "  7. 创建 Project Board (Status/Priority/Phase/Module)"
echo ""
echo "================================"
echo "✅ 初始化完成！按照 README.md 的 7 天搭建清单继续。"
