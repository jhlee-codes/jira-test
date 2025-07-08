#!/bin/sh
. "$(dirname "$0")/_/husky.sh"

COMMIT_MSG_FILE=$1
COMMIT_MSG=$(cat "$COMMIT_MSG_FILE")

# 브랜치명에서 이슈 키 추출 (예: MNW-123-기능명 → MNW-123)
BRANCH_NAME=$(git symbolic-ref --short HEAD)
ISSUE_KEY=$(echo "$BRANCH_NAME" | grep -oE '[A-Z]+-[0-9]+')

# 이미 이슈 키가 있으면 추가 안 함
if echo "$COMMIT_MSG" | grep -q "$ISSUE_KEY"; then
  exit 0
fi

# 앞에 이슈 키 붙이기
echo "$ISSUE_KEY $COMMIT_MSG" > "$COMMIT_MSG_FILE"