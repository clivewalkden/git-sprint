#!/usr/bin/env bats

setup() {
  PROJECT_ROOT="$(cd "$BATS_TEST_DIRNAME/.." && pwd)"
  TMPDIR="$(mktemp -d)"
  cd "$TMPDIR"
  git init >/dev/null 2>&1
  git config user.email "test@example.com"
  git config user.name "Test Bot"
  touch README.md
  git add README.md
  git commit -m "initial" >/dev/null 2>&1
}

teardown() {
  rm -rf "$TMPDIR"
}

@test "dry-run prints git commands for init" {
  run "$PROJECT_ROOT/git-sprint" --dry-run init
  [ "$status" -eq 0 ]
  [[ "$output" == *"DRY-RUN: git" ]]
}
