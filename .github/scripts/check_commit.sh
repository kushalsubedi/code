#!/bin/bash
set -e

COMMIT_MSG=$(git log -1 --pretty=format:"%s" | tr -d '\r' | sed 's/^[ \t]*//;s/[ \t]*$//')
echo "Commit: \"$COMMIT_MSG\""

REGEX='^(feat|fix|chore|docs|style|refactor|perf|test|build|ci|revert|breaking)(\([a-z0-9_-]+\))?(!)?: .+'

if echo "$COMMIT_MSG" | grep -Eq '^Merge [a-f0-9]{7,} into [a-f0-9]{7,}$'; then
  echo "Skipping merge commit."
  exit 0
fi

if ! echo "$COMMIT_MSG" | grep -Eq "$REGEX"; then
  echo "::error ::Commit doesn't follow conventional format."
  echo "Example: feat(auth): add login endpoint"
  exit 1
fi

echo "Conventional Commit Check Passed"

