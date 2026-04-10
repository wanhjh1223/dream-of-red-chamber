#!/bin/bash
# 红楼梦续写脚本

PROJECT_DIR="/root/.openclaw/workspace/dream-of-red-chamber"
NEXT_FILE="$PROJECT_DIR/.next_chapter"
MAX_CHAPTER=120

cd "$PROJECT_DIR"

# 读取下一回编号
CHAPTER=$(cat "$NEXT_FILE" 2>/dev/null || echo "81")

# 检查是否已完成
if [ "$CHAPTER" -gt "$MAX_CHAPTER" ]; then
    echo "续写完成！总计40回。"
    exit 0
fi

# 计算上一回编号（用于参考）
PREV_CHAPTER=$((CHAPTER - 1))

# 准备系统提示词
cat > /tmp/red_chamber_prompt.txt << 'PROMPT_EOF'
你是红楼梦续书作者，需要根据前80回的伏笔和线索续写第CHAPTER_NUM回。

【续写要求】
1. 基于曹雪芹前80回的伏笔、脂砚斋批语
2. 参考周汝昌、刘心武等红学家的研究成果
3. 人物命运必须符合前80回的性格逻辑
4. 避免高鹗续书中的突兀转折（如黛玉病死、宝玉中举等）
5. 语言风格模仿曹雪芹的古典白话文
6. 每回约3000-5000字，包含章回标题

【本章提示】
请参考脂批和早期抄本中关于这一回的线索。

【输出格式】
第XX回 XXXXXX
（正文）
PROMPT_EOF

# 替换回数
sed -i "s/CHAPTER_NUM/$CHAPTER/g" /tmp/red_chamber_prompt.txt

echo "开始续写第$CHAPTER回..."
echo "时间: $(date)"

# 注意：实际续写将由OpenClaw agent调用AI完成
# 这里仅输出日志，真正的续写通过cron调用agent完成

echo "第$CHAPTER回续写任务已准备"
echo "$(date): 第$CHAPTER回" >> "$PROJECT_DIR/writing.log"

exit 0
