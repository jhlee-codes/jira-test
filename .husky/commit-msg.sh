#!/bin/sh
. "$(dirname "$0")/_/husky.sh"

COMMIT_MSG_FILE=$1
COMMIT_MSG=$(cat "$COMMIT_MSG_FILE")

# 현재 브랜치명 추출
BRANCH_NAME=$(git symbolic-ref --short HEAD)

# Jira 이슈 키 추출: 예) MNW-123
ISSUE_KEY=$(echo "$BRANCH_NAME" | grep -oE '[A-Z]+-[0-9]+')

# ISSUE_KEY가 없거나, 커밋 메시지에 이미 포함돼 있다면 그대로
if [ -z "$ISSUE_KEY" ] || echo "$COMMIT_MSG" | grep -q "$ISSUE_KEY"; then
  exit 0
fi

# 앞에 이슈 키 붙여서 덮어쓰기
echo "$ISSUE_KEY $COMMIT_MSG" > "$COMMIT_MSG_FILE"