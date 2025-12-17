#!/bin/sh
# Compute current version for git-sprint
# - On `main` (or when a tag points at HEAD) use the semver tag created by semantic-release
# - On the configured development branch return <CURRENT_VERSION>-dev

set -eu

git_root() {
    git rev-parse --show-toplevel 2>/dev/null || return 1
}

repo_root=$(git_root) || {
    echo "0.0.0"
    exit 0
}

cd "$repo_root" || exit 1

# Attempt to read configured development branch (fallback to "development")
development_branch=$(git config --get gitsprint.branch.development 2>/dev/null || echo "development")

# Current branch name
branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "")

# Determine the latest semver tag (created by semantic-release)
# If none exists, default to 0.0.0
current_version=$(git describe --tags --abbrev=0 2>/dev/null || echo "0.0.0")

if [ "$branch" = "$development_branch" ] || [ "$branch" = "development" ]; then
    echo "${current_version}-dev"
    exit 0
fi

# If HEAD is exactly a tag, prefer that tag
if git describe --tags --exact-match >/dev/null 2>&1; then
    git describe --tags --exact-match
    exit 0
fi

echo "$current_version"
