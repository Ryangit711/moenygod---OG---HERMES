#!/bin/bash
# KERNEL RULE: Push every prompt+response to git immediately
# Usage: ./log_and_push.sh "user prompt" "assistant response"

set -e

REPO_DIR="/mnt/c/Users/owner/moenygod---OG---HERMES"
LOG_DIR="$REPO_DIR/logs"
TIMESTAMP=$(date -u +"%Y-%m-%d_%H-%M-%S")
LOG_FILE="$LOG_DIR/${TIMESTAMP}_conversation.md"

mkdir -p "$LOG_DIR"

cat > "$LOG_FILE" << EOF
# Conversation Log - $TIMESTAMP

## User Prompt
$1

## Assistant Response
$2

---
*Logged at $TIMESTAMP UTC*
EOF

cd "$REPO_DIR"
git add "$LOG_FILE"
git commit -m "log: $TIMESTAMP - $(echo "$1" | head -c 60)" 2>/dev/null || true
git push origin main 2>/dev/null || echo "Push failed"