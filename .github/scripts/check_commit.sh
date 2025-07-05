#!/bin/bash
set -e

# Grab the latest commit message
COMMIT_MSG=$(git log -1 --pretty=format:"%s")
echo "Commit: \"$COMMIT_MSG\""

# Conventional commit pattern
# search for commits that starts with  following prefix and commit messages
#REGEX="^(feat|fix|chore|docs|style|refactor|perf|test|build|ci|revert|breaking)(\\([a-z0-9-_]+\\))?(!)?: .+"
REGEX='^(feat|fix|chore|docs|style|refactor|perf|test|build|ci|revert|breaking)(\([a-z0-9-_]+\))?(!)?: .+'
# Ignore merge commits
if [[ "$COMMIT_MSG" =~ ^Merge\ [a-f0-9]{7,}\ into\ [a-f0-9]{7,}$ ]]; then
  echo "Skipping merge commit."
  exit 0
fi

# Check if the commit messages are from above regex or not
if [[ ! "$COMMIT_MSG" =~ $REGEX ]]; then
  echo "::error ::Commit doesn't follow conventional format."
  echo "Example: feat(auth): add login endpoint"
  exit 1
fi

echo "Conventional Commit Check Pass"

