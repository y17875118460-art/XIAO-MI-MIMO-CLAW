#!/bin/bash
# 双向同步：workspace <-> GitHub (XIAO-MI-MIMO-CLAW)
# 用法: bash sync.sh [push|pull|sync]
# 默认: sync (先 pull 再 push)

set -e
WORKSPACE="/root/.openclaw/workspace"
BRANCH="master"

do_pull() {
  echo "=== Pull: GitHub → 本地 ==="
  cd "$WORKSPACE" || exit 1
  git pull origin "$BRANCH" --rebase --no-edit 2>&1
  echo "✅ Pull 完成"
}

do_push() {
  echo "=== Push: 本地 → GitHub ==="
  cd "$WORKSPACE" || exit 1

  # 检查是否有变更
  if git diff --quiet && git diff --cached --quiet && [ -z "$(git ls-files --others --exclude-standard)" ]; then
    echo "无变更，跳过"
    return 0
  fi

  git add -A
  git commit -m "sync: $(date '+%Y-%m-%d %H:%M')" 2>&1
  git push origin "$BRANCH" 2>&1
  echo "✅ Push 完成"
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
