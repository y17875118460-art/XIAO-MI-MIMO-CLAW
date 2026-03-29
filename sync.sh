#!/bin/bash
# 双向同步：workspace <-> XIAO-MI-MIMO-CLAW 仓库
# 用法: bash sync.sh [push|pull|sync]
# 默认: sync (先 pull 再 push)

REPO_DIR="/root/.openclaw/workspace/XIAO-MI-MIMO-CLAW"
WORKSPACE="/root/.openclaw/workspace"

# 需要同步的文件列表
SYNC_FILES=(
  AGENTS.md
  BOOTSTRAP.md
  HEARTBEAT.md
  IDENTITY.md
  MEMORY.md
  SOUL.md
  TOOLS.md
  USER.md
)
SYNC_DIRS=(
  memory
  novel
)

do_pull() {
  echo "=== Pull: 仓库 -> 工作区 ==="
  cd "$REPO_DIR" || exit 1
  git pull origin main --no-edit 2>&1

  for f in "${SYNC_FILES[@]}"; do
    if [ -f "$REPO_DIR/$f" ]; then
      cp "$REPO_DIR/$f" "$WORKSPACE/$f"
      echo "  <- $f"
    fi
  done
  for d in "${SYNC_DIRS[@]}"; do
    if [ -d "$REPO_DIR/$d" ]; then
      cp -r "$REPO_DIR/$d" "$WORKSPACE/$d"
      echo "  <- $d/"
    fi
  done
  echo "Pull 完成"
}

do_push() {
  echo "=== Push: 工作区 -> 仓库 ==="
  cd "$REPO_DIR" || exit 1

  for f in "${SYNC_FILES[@]}"; do
    if [ -f "$WORKSPACE/$f" ]; then
      cp "$WORKSPACE/$f" "$REPO_DIR/$f"
      echo "  -> $f"
    fi
  done
  for d in "${SYNC_DIRS[@]}"; do
    if [ -d "$WORKSPACE/$d" ]; then
      cp -r "$WORKSPACE/$d" "$REPO_DIR/$d"
      echo "  -> $d/"
    fi
  done

  # 检查是否有变更
  if git diff --quiet && git diff --cached --quiet; then
    echo "无变更，跳过提交"
    return 0
  fi

  git add -A
  git commit -m "sync: $(date '+%Y-%m-%d %H:%M')" 2>&1
  git push origin main 2>&1
  echo "Push 完成"
}

case "${1:-sync}" in
  pull) do_pull ;;
  push) do_push ;;
  sync)
    do_pull
    do_push
    ;;
  *)
    echo "用法: $0 [push|pull|sync]"
    exit 1
    ;;
esac
