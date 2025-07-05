#!/bin/bash

set -e

echo "Enter commit message to test:"
read -r COMMIT_MSG

COMMIT_MSG=$(echo "$COMMIT_MSG" | tr -d '\r' | sed 's/^[ \t]*//;s/[ \t]*$//')
echo "Testing commit: \"$COMMIT_MSG\""

# Check for merge commits first
if [[ "$COMMIT_MSG" =~ ^Merge\ [a-f0-9]{7,}\ into\ [a-f0-9]{7,}$ ]]; then
  echo "Skipping merge commit."
  exit 0
fi

# Check conventional commit format with two separate patterns
# Pattern 1: Normal commits (type: msg, type(scope): msg)
NORMAL_REGEX='^(feat|fix|chore|docs|style|refactor|perf|test|build|ci|revert|breaking)(\([a-z0-9-_]+\))?: .+'
# Pattern 2: Breaking change commits (type!: msg, type(scope)!: msg)
BREAKING_REGEX='^(feat|fix|chore|docs|style|refactor|perf|test|build|ci|revert|breaking)(\([a-z0-9-_]+\))?!: .+'

if [[ "$COMMIT_MSG" =~ ^Merge\ [a-f0-9]{7,}\ into\ [a-f0-9]{7,}$ ]]; then
  echo "Skipping merge commit."
  exit 0
fi
if [[ "$COMMIT_MSG" =~ $NORMAL_REGEX ]] || [[ "$COMMIT_MSG" =~ $BREAKING_REGEX ]]; then
  echo "✅ Valid conventional commit"
else
  echo "❌ Invalid conventional commit"
  echo "Example valid: feat(auth): add login endpoint"
  echo "Supports: feat!: drop legacy support, fix(scope)!: big fix"
  exit 1
fi


