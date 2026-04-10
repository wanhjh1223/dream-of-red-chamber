#!/bin/bash
# GitHub 自动推送脚本（Token 版本）

PROJECT_DIR="/root/.openclaw/workspace/dream-of-red-chamber"
cd "$PROJECT_DIR"

# 检查是否有变更
if [ -z "$(git status --porcelain)" ]; then
    echo "没有变更需要推送"
    exit 0
fi

# 获取当前章节号
CHAPTER=$(cat .next_chapter 2>/dev/null || echo "81")
PREV_CHAPTER=$((CHAPTER - 1))

# 配置 git
git config user.email "bot@openclaw.local"
git config user.name "OpenClaw Bot"

# 添加所有变更
git add -A

# 提交
git commit -m "更新第$(printf "%03d" $PREV_CHAPTER)回 - $(date '+%Y-%m-%d %H:%M')"

# 推送到 GitHub
git push origin main
echo "✅ 已推送到 GitHub"
