#!/bin/sh
# Post-commit hook that updates the VERSION file and commits it when changed.
# Install to .git/hooks/post-commit (see contrib/install_update_version_hook.sh)
set -eu

# Avoid running when the last commit is already a version update to prevent loops
last_msg=$(git log -1 --pretty=%B 2>/dev/null || echo "")
case "$last_msg" in
  chore\(version\):*)
    exit 0
    ;;
esac

repo_root=$(git rev-parse --show-toplevel 2>/dev/null || true)
if [ -z "$repo_root" ]; then
  exit 0
fi

"$repo_root/scripts/write_version_file.sh"

# If VERSION changed relative to HEAD, add and commit it
if ! git diff --quiet HEAD -- "$repo_root/VERSION" 2>/dev/null; then
  git add "$repo_root/VERSION"
  version=$(cat "$repo_root/VERSION")
  git commit -m "chore(version): update VERSION to $version" --no-verify || true
fi

exit 0
