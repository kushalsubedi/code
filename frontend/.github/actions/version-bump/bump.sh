#!/bin/bash
set -e

if [ -z "$GITHUB_OUTPUT" ]; then
  echo " GITHUB_OUTPUT is not set"
  exit 1
fi

latest_tag=$(git describe --tags `git rev-list --tags --max-count=1` 2>/dev/null || echo "v0.0.0")
commit_msg=$(git log -1 --pretty=%s)
echo "HI"
version=${latest_tag#v}
major=$(echo "$version" | cut -d. -f1)
minor=$(echo "$version" | cut -d. -f2)
patch=$(echo "$version" | cut -d. -f3)

if [[ "$commit_msg" == feat!* ]] || [[ "$commit_msg" == *BREAKING* ]]; then
    major=$((major+1)); minor=0; patch=0
elif [[ "$commit_msg" == feat:* ]]; then
    minor=$((minor+1)); patch=0
elif [[ "$commit_msg" == fix:* ]]; then
    patch=$((patch+1))
else
    echo "skip=true" >> "$GITHUB_OUTPUT"
    echo "$GITHUB_OUTPUT"
    echo "Version is updated ------"
    echo "HIIIIIIIIIIIIIIIIIIIIIIIIIIIII"

    exit 0
fi

new_tag="v$major.$minor.$patch"
echo "new_tag=$new_tag" >> "$GITHUB_OUTPUT"
echo "skip=false" >> "$GITHUB_OUTPUT"

