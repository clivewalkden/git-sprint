#!/bin/sh
# Write computed version to VERSION file at repository root.
set -eu

repo_root=$(git rev-parse --show-toplevel 2>/dev/null || true)
if [ -z "$repo_root" ]; then
  echo "Not a git repository; cannot write VERSION" >&2
  exit 1
fi

script_dir="$repo_root/scripts"
get_version_script="$script_dir/get_version.sh"

if [ ! -x "$get_version_script" ]; then
  echo "get_version.sh not found or not executable: $get_version_script" >&2
  exit 1
fi

version=$("$get_version_script")
version_file="$repo_root/VERSION"

old_version=""
if [ -f "$version_file" ]; then
  old_version=$(cat "$version_file")
fi

if [ "$old_version" = "$version" ]; then
  echo "VERSION unchanged: $version"
  exit 0
fi

printf "%s\n" "$version" > "$version_file"
echo "WROTE $version_file: $version"
exit 0
