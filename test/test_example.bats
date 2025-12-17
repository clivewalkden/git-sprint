#!/usr/bin/env bats

@test "scripts exist" {
  run bash -c "ls | grep -E '(^git-sprint|gitsprint-).*' || true"
  [ "$status" -eq 0 ]
}
