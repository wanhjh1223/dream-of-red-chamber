#!/bin/bash
# 红楼梦续书更新脚本
# 每6小时自动更新一回

WORKSPACE="/root/.openclaw/workspace/dream-of-red-chamber"
NEXT_CHAPTER_FILE="$WORKSPACE/.next_chapter"
LOCK_FILE="$WORKSPACE/.update_lock"

# 获取下一回编号
if [ -f "$NEXT_CHAPTER_FILE" ]; then
    NEXT_CHAPTER=$(cat "$NEXT_CHAPTER_FILE")
else
    NEXT_CHAPTER=82
fi

# 检查是否已存在更新锁
if [ -f "$LOCK_FILE" ]; then
    echo "[$(date)] 已有更新任务在运行，跳过本次更新"
    exit 0
fi

# 创建锁文件
touch "$LOCK_FILE"

echo "[$(date)] 开始更新第${NEXT_CHAPTER}回..."

# 更新下一回编号
echo $((NEXT_CHAPTER + 1)) > "$NEXT_CHAPTER_FILE"

# 提交当前进度
cd "$WORKSPACE"
git add -A
git commit -m "完成第$(printf "%03d" $((NEXT_CHAPTER - 1)))回" 2>/dev/null || true

# 推送到 GitHub（如果配置了远程仓库）
if git remote get-url origin >/dev/null 2>&1; then
    echo "[$(date)] 推送到 GitHub..."
    git push origin master || git push origin main || echo "[$(date)] 推送失败，请检查网络或权限"
else
    echo "[$(date)] 未配置 GitHub 远程仓库，跳过推送"
fi

echo "[$(date)] 第${NEXT_CHAPTER}回更新完成"

# 移除锁文件
rm -f "$LOCK_FILE"
