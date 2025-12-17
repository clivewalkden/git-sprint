#!/bin/sh
# Install the update-version post-commit hook into the current repo
set -eu

repo_root=$(git rev-parse --show-toplevel 2>/dev/null || true)
if [ -z "$repo_root" ]; then
  echo "Not inside a git repository." >&2
  exit 1
fi

hook_src="$repo_root/scripts/update_version_hook.sh"
hook_dest="$repo_root/.git/hooks/post-commit"

if [ ! -x "$hook_src" ]; then
  echo "Making $hook_src executable"
  chmod +x "$hook_src" || true
fi

cp "$hook_src" "$hook_dest"
chmod +x "$hook_dest"

echo "Installed post-commit hook to $hook_dest"
echo "It will update VERSION after each commit when necessary."
